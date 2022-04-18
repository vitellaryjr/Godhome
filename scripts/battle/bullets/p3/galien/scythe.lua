local Scythe, super = Class(Bullet)

function Scythe:init(x, y)
    super:init(self, x, y, "battle/p3/galien/scythe_idle")
    self.collider = CircleCollider(self, 16, 16, 12)
end

function Scythe:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(0.5, function()
        self.started = true
        self:setSprite("battle/p3/galien/scythe_spin", 0.1, true)
    end)
end

function Scythe:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    self.graphics.spin = Utils.approach(self.graphics.spin, 0.5, 0.03*DTMULT)
    if self.started then
        if soul.x > self.x then
            self.physics.speed_x = Utils.approach(self.physics.speed_x, 8, 0.25*DTMULT)
        else
            self.physics.speed_x = Utils.approach(self.physics.speed_x, -8, 0.25*DTMULT)
        end
    end
    if self.started then
        self.physics.speed_y = self.physics.speed_y + 0.3*DTMULT
    end
    local rad = 28
    if self.y > arena.bottom - rad then
        self.physics.speed_y = self.physics.speed_y*-1
        self.y = arena.bottom - (rad+1)
    elseif self.x < arena.left + rad or self.x > arena.right - rad then
        self.physics.speed_x = self.physics.speed_x*-1
        self.x = Utils.clamp(self.x, arena.left + (rad+1), arena.right - (rad+1))
    end
end

return Scythe