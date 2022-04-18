local Flukemarm, super = Class("boss")

function Flukemarm:init()
    super:init(self)
    
    self.name = "Flukemarm"
    self:setActor("p2/flukemarm")

    self.max_health = 650
    self.health = 650

    self.waves = {
        "p2/flukemarm/flukes",
        "p2/flukemarm/flukemunga",
    }

    self.text = {
        "* Flukemarm is disgusting."
    }
end

return Flukemarm