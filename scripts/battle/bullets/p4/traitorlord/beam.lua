local Beam, super = Class("movement")

function Beam:init(x, y, type, dir)
    super:init(self, x, y, type, "battle/p4/traitorlord/pound")
    self.sprite:play(0.1, true)
    self:setOrigin(0.5, 1)
    self:setHitbox(8, 0, 6, 80)
    self.double_damage = true

    self.alpha = 0.5
    self.scale_x = 0

    self.dir = dir
end

function Beam:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.3, self, {alpha = 1, scale_x = 2*self.dir})
    self.wave.timer:tween(0.5, self.physics, {speed_x = 8*self.dir})
end

return Beam