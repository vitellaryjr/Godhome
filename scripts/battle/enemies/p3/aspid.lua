local Aspid, super = Class("enemy")

function Aspid:init()
    super:init(self)

    self.name = "Aspid Hunter"
    self:setActor("p3/aspid")

    self.max_health = 45
    self.health = 45

    self.type = "aspid"
end

return Aspid