local Baldur, super = Class("enemy")

function Baldur:init()
    super:init(self)

    self.name = "Sharp Baldur"
    self:setActor("p3/sharp_baldur")

    self.max_health = 75
    self.health = 75

    self.type = "sharp_baldur"
end

return Baldur