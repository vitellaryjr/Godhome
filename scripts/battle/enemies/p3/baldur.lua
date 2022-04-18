local Baldur, super = Class("enemy")

function Baldur:init()
    super:init(self)

    self.name = "Baldur"
    self:setActor("p3/baldur")

    self.max_health = 45
    self.health = 45

    self.type = "baldur"
end

return Baldur