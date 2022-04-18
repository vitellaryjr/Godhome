local Spike, super = Class(Bullet)

function Spike:init(x, y)
    super:init(self, x, y, "battle/p5/radiance/spike")
    self:setOriginExact(0, 14)
    self:setHitbox(0,5, 8,11)
end

return Spike