local Blade, super = Class(Bullet)

function Blade:init(x, y, dir)
    super:init(self, x, y, "battle/p3/galien/blade")
    self.sprite:play(0.1, true)
    self.collider = CircleCollider(self, 8, 8, 6)

    self.physics = {
        speed = 4,
        direction = dir,
    }
    self.graphics.spin = 0.4*Utils.sign(math.cos(dir))
end

function Blade:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    local collided = false
    for _,line in ipairs(arena.collider.colliders) do
        if self:collidesWith(line) then
            local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
            local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
            self.physics.direction = Vector.toPolar(nvx,nvy)
            self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), 2)
            collided = true
        end
    end
    if collided then
        self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
    end
end

return Blade