-- return {
--     id = "flukemarm",
--     width = 42, height = 70,

--     path = "enemies/p2/flukemarm",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.13, true},
--     }
-- }

local Flukemarm, super = Class(Actor)

function Flukemarm:init()
    super:init(self)

    self.width = 42
    self.height = 70

    self.path = "enemies/p2/flukemarm"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.13, true},
    }
end

return Flukemarm