-- return {
--     id = "col_sharp_baldur",
--     width = 24, height = 19,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"sharp_baldur", 0.4, true},
--     }
-- }

local SharpBaldur, super = Class(Actor)

function SharpBaldur:init()
    super:init(self)

    self.width = 24
    self.height = 19

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"sharp_baldur", 0.4, true},
    }
end

return SharpBaldur