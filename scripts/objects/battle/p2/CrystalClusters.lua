local Crystals, super = Class("UIAttachment")

function Crystals:init()
    super:init(self, 150)
    local sprite = Sprite("battle/p2/crystalguardian/bg_crystals", 0,0)
    sprite:setOrigin(0,1)
    self:addChild(sprite)
end

return Crystals