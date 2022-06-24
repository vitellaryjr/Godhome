local Mawlek, super = Class(Sprite)

function Mawlek:init(x, y, rot, alpha)
    super:init(self, "battle/p1/broodingmawlek/bg_deadmawlek", x, y)
    self:setOrigin(0.5,1)
    self:setScale(2)
    self.rotation = rot
    self.alpha = alpha
end

local MawlekBodies, super = Class("UIAttachment")

function MawlekBodies:init()
    super:init(self, 80)
    self:addChild(Mawlek(-10, 5, math.pi/4 - 0.1, 0.5))
    self:addChild(Mawlek(210, 20, -math.pi/8, 0.3))
    self:addChild(Mawlek(400, -5, math.pi/6, 0.2))
    self:addChild(Mawlek(640, 15, -math.pi/4, 0.5))
end

return MawlekBodies