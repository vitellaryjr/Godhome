local Mossy, super = Class("boss")

function Mossy:init()
    super:init(self)

    self.name = "Massive Moss Charger"
    self:setActor("p1/mosscharger")

    self.max_health = 480
    self.health = 480

    self.waves = {"p1/mosscharger/attack"}
    
    self.text = {
        "* The grass shifts beneath you.",
        "* There's strength in numbers.",
        "* The floor peeks at you with\norange eyes.",
    }
end

return Mossy