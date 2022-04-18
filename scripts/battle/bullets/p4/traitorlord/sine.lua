local Scythe, super = Class(Bullet)

function Scythe:init(x, sx, freq)
    super:init(self, x, Game.battle.arena.y, "battle/p2/mantislords/scythe")
    self.sprite:play(0.1, true)
    self:setHitbox(7.5,2.5,25,5)
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.2,
    }
    self.physics.speed_x = sx

    self.sine = 0
    self.freq = freq
end

function Scythe:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(1.8, function()
        self:fadeOutAndRemove(0.05)
    end)
end

function Scythe:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    self.sine = self.sine + dt
    self.y = arena.y + arena.height*0.4*math.sin(self.sine*self.freq)
end

return Scythe