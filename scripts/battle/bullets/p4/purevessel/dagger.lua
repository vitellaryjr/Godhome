local Dagger, super = Class(Bullet)

function Dagger:init(x, y, angle)
    super:init(self, x, y, "battle/p4/purevessel/dagger")
    self:setHitbox(7, 3, 10, 3)
    self.rotation = angle
    self.physics = {
        speed = 14,
        direction = angle,
    }
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    Game.battle.timer:tween(0.5, mask, {amount = 0})
end

return Dagger