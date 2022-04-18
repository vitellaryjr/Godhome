local Spike, super = Class(Bullet)

function Spike:init(x, y)
    super:init(self, x, y, "battle/p3/grimm/spike_spawn")
    self.sprite:play(0.05, false)
    self:setOrigin(0.5, 1)
    self:setHitbox(6, 0, 4, 70)
    self.collidable = false
end

function Spike:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(0.5, function()
        self:setSprite("battle/p3/grimm/spike_extend", 0.02, false)
        self.wave.timer:after(0.06, function()
            self.collidable = true
        end)
    end)
    self.wave.timer:after(0.8, function()
        self.collidable = false
        self:setSprite("battle/p3/grimm/spike_retract", 0.05, false, function(sprite) self:remove() end)
    end)
end

return Spike