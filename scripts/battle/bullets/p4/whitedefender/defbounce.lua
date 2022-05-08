local Dung, super = Class("nailbase")

function Dung:init(x, y, dir)
    super:init(self, x, y, "battle/p1/dungdefender/defenderball")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 10)
    self.enemy = Game.battle:getEnemyBattler("p1/dungdefender")

    self.rotation = Utils.random(2*math.pi)
    self.graphics.spin = Utils.random(0.1,0.2)*Utils.sign(math.cos(dir))
    self.physics = {
        speed = 12,
        direction = dir,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }

    self.bounces = 0
    self.state = "spawning"
end

function Dung:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.state == "spawning" then
        if not Game.battle:checkSolidCollision(self) then
            self.state = "bouncing"
        end
    elseif self.state == "bouncing" then
        local collided, collided_wall, collided_floor = false, false, false
        for i,line in ipairs(arena.collider.colliders) do
            if i ~= 1 and self:collidesWith(line) then
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), self.physics.speed*DTMULT)
                collided = true
                if i == 2 or i == 4 then
                    collided_wall = true
                else
                    collided_floor = true
                end
            end
        end
        if collided then
            self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
            if collided_floor then
                self.bounces = self.bounces + 1
            end
            if self.bounces == 2 then
                self.wave.timer:after(0.2, function()
                    self.state = "preparing"
                    local sx, sy
                    if self.physics.direction then
                        sx, sy = self.physics.speed*math.cos(self.physics.direction), self.physics.speed*math.sin(self.physics.direction)
                    else -- i dont understand how it could ever be false but sometimes it is
                        sx, sy = self.physics.speed_x, self.physics.speed_y
                    end
                    self.physics = {
                        speed_x = sx,
                        speed_y = sy,
                    }
                    self:setParent(Game.battle.mask)
                end)
            end
        end
    elseif self.state == "preparing" then
        self.physics.speed_x = Utils.approach(self.physics.speed_x, 0, 0.5*DTMULT)
        self.physics.speed_y = Utils.approach(self.physics.speed_y, 0, 0.5*DTMULT)
        if self:collidesWith(arena.collider.colliders[2]) or self:collidesWith(arena.collider.colliders[4]) then
            self.physics.speed_x = self.physics.speed_x*-1
            self.graphics.spin = self.graphics.spin*-1
        end
        self.graphics.spin = Utils.approach(self.graphics.spin, 0.5*Utils.sign(self.graphics.spin), 0.05*DTMULT)
        if self.physics.speed_y == 0 then
            self.state = "diving"
            self.wave.timer:after(0.3, function()
                self.physics = {
                    speed_y = 6,
                    gravity = 1,
                    gravity_direction = math.pi/2,
                }
            end)
        end
    elseif self.state == "diving" then
        if self:collidesWith(arena.collider.colliders[3]) then
            self.state = "done"
            Game.battle.shake = 3
            local dist = 10
            local sx = self.x
            self.wave.timer:script(function(wait)
                wait(0.05)
                for i=1,8 do
                    self.wave:spawnBulletTo(Game.battle.mask, "p4/whitedefender/spike", sx + dist, arena.bottom + 40, 1)
                    self.wave:spawnBulletTo(Game.battle.mask, "p4/whitedefender/spike", sx - dist, arena.bottom + 40, -1)
                    dist = dist + 30
                    wait(0.15)
                end
            end)
        end
    end
end

function Dung:hit(source, damage)
    super:hit(self, source, damage)
    if self.state ~= "bouncing" then return end
    local dx, dy = self.x-source.x, self.y-source.y
    if math.abs(dx) > math.abs(dy) then
        if Utils.sign(dx) ~= Utils.sign(math.cos(self.physics.direction)) then
            self.physics.direction = math.pi-self.physics.direction
        end
    else
        if Utils.sign(dy) ~= Utils.sign(math.sin(self.physics.direction)) then
            self.physics.direction = (-self.physics.direction)%(math.pi*2)
        end
    end
end

return Dung