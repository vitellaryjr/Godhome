local Zote, super = Class("boss")

function Zote:init()
    super:init(self)
    
    self.name = "Grey Prince Zote"
    self:setActor("p3/greyprince")

    self.max_health = 700
    self.health = 700

    self.waves = {
        "p3/greyprince/fall",
        "p3/greyprince/enemies",
        "p3/greyprince/bombs",
    }

    self.text = {
        "* Bretta faints at the sight.",
        "* Strength beats strength.",
        "* Zote thinks he has identified your\nweak point, which is your body.",
    }
end

return Zote