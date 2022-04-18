-- return {
--     id = "collector",
--     width = 44, height = 54,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"collector", 0.2, true},
--     }
-- }

local Collector, super = Class(Actor)

function Collector:init()
    super:init(self)

    self.width = 44
    self.height = 54

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"collector", 0.2, true},
    }
end

return Collector