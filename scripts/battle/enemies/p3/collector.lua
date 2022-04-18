local Collector, super = Class("boss")

function Collector:init()
    super:init(self)
    
    self.name = "The Collector"
    self:setActor("p3/collector")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p3/collector/jars",
    }

    self.text = {
        "* The Collector laughs gleefully.",
        "* Shattered glass covers the floor.",
        "* Grubfather cheers you on.",
        "* Void given love?",
        "* The Collector tries to put you in\na jar.",
    }
end

function Collector:getAttackTension()
    return 0
end

return Collector