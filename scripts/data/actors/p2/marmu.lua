-- return {
--     id = "marmu",
--     width = 40, height = 36,

--     path = "enemies/p2/marmu",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0, false},
--     }
-- }

local Marmu, super = Class(Actor)

function Marmu:init()
    super:init(self)

    self.width = 40
    self.height = 36

    self.path = "enemies/p2/marmu"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0, false},
    }
end

return Marmu