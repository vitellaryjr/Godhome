local Bounce, super = Class("nailbase")

function Bounce:init(x, y, dir, sprite)
    super:init(self, x, y, sprite)
    self.rotation = Utils.random(2*math.pi)
    self.graphics.spin = Utils.random(0.1,0.2)*Utils.sign(math.cos(dir))
    self.physics = {
        speed = 12,
        direction = dir,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    self.spawning = true
end

function Bounce:update()
    super:update(self)
    if self.spawning then
        self.spawning = Game.battle:checkSolidCollision(self)
    else
        local arena = Game.battle.arena
        local collided = false
        for _,line in ipairs(arena.collider.colliders) do
            if self:collidesWith(line) then
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), self.physics.speed*DTMULT)
                collided = true
            end
        end
        if collided then
            self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
        end
    end
end

function Bounce:hit(source, damage)
    super:hit(self, source, damage)
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

return Bounce