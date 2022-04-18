-- return {
--     id = "noeyes",
--     width = 49, height = 48,

--     path = "enemies/p4/noeyes",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local NoEyes, super = Class(Actor)

function NoEyes:init()
    super:init(self)

    self.width = 49
    self.height = 48

    self.path = "enemies/p4/noeyes"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return NoEyes