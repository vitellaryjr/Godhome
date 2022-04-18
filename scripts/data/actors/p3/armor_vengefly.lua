-- return {
--     id = "col_armor_vengefly",
--     width = 22, height = 22,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"armor_vengefly", 0.3, true},
--     }
-- }

local ArmorVengefly, super = Class(Actor)

function ArmorVengefly:init()
    super:init(self)

    self.width = 22
    self.height = 22

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"armor_vengefly", 0.3, true},
    }
end

return ArmorVengefly