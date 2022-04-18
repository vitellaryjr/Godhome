local Crystals, super = Class("battle/UIAttachment")

function Crystals:init()
    super:init(self, 150)
    local sprite = Sprite("battle/p4/enragedguardian/bg_crystals", 0,0)
    sprite:setOrigin(0,1)
    self:addChild(sprite)
end

return Crystals