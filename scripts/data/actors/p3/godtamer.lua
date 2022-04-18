-- return {
--     id = "godtamer",
--     width = 54, height = 56,

--     path = "enemies/p3/godtamer",
--     default = "idle",
--     animations = {
--         ["idle"] = {"tamer", 0.4, true},
--     }
-- }

local GodTamer, super = Class(Actor)

function GodTamer:init()
    super:init(self)

    self.width = 54
    self.height = 56

    self.path = "enemies/p3/godtamer"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"tamer", 0.4, true},
    }
end

return GodTamer