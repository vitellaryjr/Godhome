-- return {
--     id = "brokenvessel",
--     width = 40, height = 28,

--     path = "enemies/p2/brokenvessel",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--     }
-- }

local BrokenVessel, super = Class(Actor)

function BrokenVessel:init()
    super:init(self)

    self.width = 40
    self.height = 28

    self.path = "enemies/p2/brokenvessel"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return BrokenVessel