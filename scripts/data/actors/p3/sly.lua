-- return {
--     id = "sly",
--     width = 66, height = 28,

--     path = "enemies/p3/sly",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--         ["stagger"] = {"stagger", 0, false},
--     }
-- }

local Sly, super = Class(Actor)

function Sly:init()
    super:init(self)

    self.width = 66
    self.height = 28

    self.path = "enemies/p3/sly"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["stagger"] = {"stagger", 0, false},
    }
end

return Sly