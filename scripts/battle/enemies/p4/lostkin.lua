local LostKin, super = Class("boss")

function LostKin:init()
    super:init(self)
    
    self.name = "Lost Kin"
    self:setActor("p4/lostkin")

    self.max_health = 750
    self.health = 750

    self.waves = {
        "p4/lostkin/arcs",
        "p4/lostkin/slam",
        "p4/lostkin/seeds",
        "p4/lostkin/arcs_balloons",
        "p4/lostkin/slam_balloons",
    }

    self.text = {
        "* Your sibling looks at you solemnly.",
        "* It's thinking too much.",
        "* An imperfect vessel.",
    }
end

return LostKin