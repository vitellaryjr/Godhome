local ClothClub, super = Class("UIAttachment")

function ClothClub:init()
    super:init(self, 60)
    local sprite = Sprite("battle/p4/traitorlord/bg_club", 450,0)
    sprite:setOrigin(0.5, 1)
    sprite:setScale(2)
    self:addChild(sprite)
end

return ClothClub