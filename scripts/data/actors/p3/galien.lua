-- return {
--     id = "galien",
--     width = 42, height = 42,

--     path = "enemies/p3/galien",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 1, false},
--     }
-- }

local Galien, super = Class(Actor)

function Galien:init()
    super:init(self)

    self.width = 42
    self.height = 42

    self.path = "enemies/p3/galien"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 1, false},
    }
end

return Galien