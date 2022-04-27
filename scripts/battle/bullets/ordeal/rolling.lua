local Rolling, super = Class("ordeal/zotebase")

function Rolling:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom - 12, "battle/ordeal/zoteling_roll")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
    self.health = 45

    self.graphics.spin = 0.5
    self.physics = {
        speed_x = Utils.random(-3,3),
        speed_y = -4,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }

    self.rolling = false
end

function Rolling:update()
    super:update(self)
    local arena = Game.battle.arena
    if not self.rolling then
        if self:collidesWith(arena.collider.colliders[3]) then
            local angle = Utils.angle(0,0, Utils.random(1,2)*Utils.sign(self.physics.speed_x),Utils.random(-1,-2))
            self.physics = {
                speed = 8,
                direction = angle,
            }
            self.rolling = true
        end
        if self.x < arena.left + 12 or self.x > arena.right - 12 then
            self.physics.speed_x = self.physics.speed_x * -1
            self:move(self.physics.speed_x, 0, DTMULT)
            self.x = Utils.clamp(self.x, arena.left + 12, arena.right - 12)
        end
    else
        for _,line in ipairs(arena.collider.colliders) do
            if self:collidesWith(line) then
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), self.physics.speed*DTMULT)
            end
        end
    end
end

function Rolling:hit(source, damage)
    super:hit(self, source, damage)
    if self.rolling then
        local reflect = Utils.round(Utils.angle(source.x, source.y, self.x, self.y), math.pi/2)
        if  Utils.round(math.cos(reflect)) ~= Utils.round(math.cos(self.physics.direction))
        and Utils.round(math.sin(reflect)) ~= Utils.round(math.sin(self.physics.direction)) then
            local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
            local mx,my = Vector.fromPolar(reflect+math.pi/2, 1)
            local nvx,nvy = Vector.mirror(vx,vy, mx,my)
            self.physics.direction = Vector.toPolar(nvx,nvy)
        end
    end
end

return Rolling