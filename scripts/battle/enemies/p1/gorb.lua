local Gorb, super = Class("floatyBoss")

function Gorb:init()
    super:init(self)

    self.name = "Gorb"
    self:setActor("p1/gorb")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p1/gorb/spears",
    }

    self.text = {
        "* Gorb wriggles.",
        "* Gorb is a lot smarter than you.",
        "* Gorb seems to be on a different\nplane of existence.",
        "* Mmmmmonomonomonomononomo",
    }
end

return Gorb