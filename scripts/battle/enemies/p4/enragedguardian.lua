local Guardian, super = Class("boss")

function Guardian:init()
    super:init(self)

    self.name = "Enraged Guardian"
    self:setActor("p2/crystalguardian")

    self.max_health = 600
    self.health = 600

    self.waves = {
        "p4/enragedguardian/static",
        "p4/enragedguardian/crawlers",
    }

    self.text = {
        "* Enraged Guardian wants to go back\nto sleep.",
        "* The floor has been scorched by\nlasers.",
        "* Enraged Guardian screeches.\nIt sounds familiar.",
    }

    self.double_damage = true
end

return Guardian