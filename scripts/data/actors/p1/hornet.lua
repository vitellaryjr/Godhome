-- return {
--     id = "hornet",
--     width = 52, height = 50,

--     path = "enemies/p1/hornet",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--     }
-- }

local Hornet, super = Class(Actor)

function Hornet:init()
    super:init(self)

    self.width = 52
    self.height = 50

    self.path = "enemies/p1/hornet"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return Hornet