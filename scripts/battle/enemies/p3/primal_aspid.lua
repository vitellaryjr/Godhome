local Aspid, super = Class("enemy")

function Aspid:init()
    super:init(self)

    self.name = "Primal Aspid"
    self:setActor("p3/primal_aspid")

    self.max_health = 60
    self.health = 60

    self.type = "primal_aspid"
end

return Aspid