local Sword, super = Class(Bullet)

function Sword:init(x, y)
    super:init(self, x, y, "battle/p4/purevessel/sword")
    self:setOrigin(0.5, 1)
    self:setHitbox(6.5, 0, 2, 70)
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite.scale_x = 0
    self.sprite.alpha = 0
    self.collidable = false
end

function Sword:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.1, self.sprite, {scale_x = 1, alpha = 1}, "linear", function() self.collidable = true end)
end

function Sword:disappear()
    self.collidable = false
    self.wave.timer:tween(0.1, self.sprite, {scale_x = 0, alpha = 0}, "linear", function() self:remove() end)
end

return Sword