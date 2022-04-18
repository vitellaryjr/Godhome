-- return {
--     id = "col_vengefly",
--     width = 22, height = 22,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"vengefly", 0.4, true},
--     }
-- }

local Vengefly, super = Class(Actor)

function Vengefly:init()
    super:init(self)

    self.width = 22
    self.height = 22

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"vengefly", 0.4, true},
    }
end

return Vengefly