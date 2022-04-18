local BroodingMawlek, super = Class(Actor)

function BroodingMawlek:init()
    super:init(self)

    self.width = 70
    self.height = 60

    self.path = "enemies/p1/broodingmawlek"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return BroodingMawlek