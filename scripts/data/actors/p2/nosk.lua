-- return {
--     id = "nosk",
--     width = 55, height = 61,

--     path = "enemies/p2/nosk",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--     }
-- }

local Nosk, super = Class(Actor)

function Nosk:init()
    super:init(self)

    self.width = 55
    self.height = 61

    self.path = "enemies/p2/nosk"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return Nosk