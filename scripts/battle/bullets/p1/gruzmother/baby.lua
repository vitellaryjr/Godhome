local Baby, super = Class("nailbase")

function Baby:init(x, y)
    super:init(self, x, y, "battle/p1/gruzmother/baby")
    self.sprite:play(0.2, true)
    self:setHitbox(3,5,6,6)

    self.health = 30
    self.knockback = 4

    self.physics = {
        speed = 3,
        direction = Utils.random(2*math.pi),
    }
    self.scale_x = 2*Utils.sign(math.cos(self.physics.direction))
end

function Baby:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    for _,line in ipairs(arena.collider.colliders) do
        if self:collidesWith(line) then
            local angle = Utils.angle(line.x, line.y, line.x2, line.y2)
            local dir = arena.clockwise and -1 or 1
            local base = angle + dir*math.pi/2
            self.physics.direction = Utils.random(base - math.pi/2, base + math.pi/2)
        end
    end
    for _,other in ipairs(Game.stage:getObjects(Registry.getBullet("p1/gruzmother/baby"))) do
        if other ~= self and self:collidesWith(other) then
            if math.abs(self.x - other.x) > math.abs(self.y - other.y) then
                self.x = other.x - 14*Utils.sign(math.cos(self.physics.direction))
            else
                self.y = other.y - 14*Utils.sign(math.sin(self.physics.direction))
            end
            self:turn()
            other:turn()
        end
    end
    self:setPosition(
        Utils.clamp(self.x, arena.left + self.collider.width/2+1, arena.right - self.collider.width/2-1),
        Utils.clamp(self.y, arena.top + self.collider.height/2+1, arena.bottom - self.collider.height/2-1)
    )
    self.scale_x = 2*Utils.sign(math.cos(self.physics.direction))
end

function Baby:hit(source, damage)
    super:hit(self, source, damage)
    self:turn()
end

function Baby:onDefeat()
    Utils.removeFromTable(self.wave.gruzzers, self)
    super:onDefeat(self)
end

function Baby:turn()
    local sign = Utils.sign(math.cos(self.physics.direction))
    if sign > 0 then
        self.physics.direction = Utils.random(math.pi/2, 3*math.pi/3)
    else
        self.physics.direction = Utils.random(-math.pi/2, math.pi/2)
    end
end

return Baby