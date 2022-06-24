local Roots, super = Class("UIAttachment")

function Roots:init()
    super:init(self, 150)
    local sprite = Sprite("battle/p4/markoth/bg_roots", 0,7)
    sprite:setOrigin(0,1)
    sprite.alpha = 0.5
    self:addChild(sprite)
end

return Roots