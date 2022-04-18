-- return {
--     id = "purevessel",
--     width = 50, height = 72,

--     path = "enemies/p4/purevessel",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local PureVessel, super = Class(Actor)

function PureVessel:init()
    super:init(self)

    self.width = 50
    self.height = 72

    self.path = "enemies/p4/purevessel"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return PureVessel