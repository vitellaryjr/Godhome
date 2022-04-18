-- return {
--     id = "gorb",
--     width = 32, height = 64,

--     path = "enemies/p1/gorb",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--     }
-- }

local Gorb, super = Class(Actor)

function Gorb:init()
    super:init(self)

    self.width = 32
    self.height = 64

    self.path = "enemies/p1/gorb"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return Gorb