local Vengefly, super = Class("enemy")

function Vengefly:init()
    super:init(self)

    self.name = "Armored Vengefly"
    self:setActor("p3/armor_vengefly")

    self.max_health = 100
    self.health = 100

    self.type = "armor_vengefly"
end

return Vengefly