local Falling, super = Class("ordeal/zotebase")

function Falling:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.top - 12, "battle/ordeal/zoteling_roll")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
    self.health = 60

    self.graphics.spin = 0.5
    self.physics = {
        speed_x = 0,
        speed_y = 12,
    }
end

function Falling:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    self.physics.speed_x = Utils.approach(self.physics.speed_x, 0, 0.2*DTMULT)
    self.physics.speed_y = Utils.approach(self.physics.speed_y, 12, 0.4*DTMULT)
    if self.x < arena.left + 12 or self.x > arena.right - 12 then
        self.physics.speed_x = self.physics.speed_x * -1
        self:move(self.physics.speed_x, 0, DTMULT)
        self.x = Utils.clamp(self.x, arena.left + 12, arena.right - 12)
    end
    if self.y > arena.bottom + 30 then
        self.y = arena.top - 30
    end
end

function Falling:hit(source, damage)
    local angle = Utils.angle(source, self)
    angle = Utils.approachAngle(angle, math.pi/2, 0.5)
    self.physics = {
        speed_x = math.cos(angle)*8,
        speed_y = math.sin(angle)*8,
    }
    super:hit(self, source, damage)
end

return Falling