local BrokenVessel, super = Class("boss")

function BrokenVessel:init()
    super:init(self)
    
    self.name = "Broken Vessel"
    self:setActor("p2/brokenvessel")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p2/brokenvessel/arcs",
        "p2/brokenvessel/slam",
        "p2/brokenvessel/seeds",
    }

    self.text = {
        "* Your sibling looks at you.",
        "* It's thinking too much.",
    }
end

return BrokenVessel