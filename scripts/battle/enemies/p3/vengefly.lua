local Vengefly, super = Class("enemy")

function Vengefly:init()
    super:init(self)

    self.name = "Vengefly"
    self:setActor("p3/vengefly")

    self.max_health = 60
    self.health = 60

    self.type = "vengefly"
end

return Vengefly