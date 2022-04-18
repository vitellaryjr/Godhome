-- return {
--     id = "col_baldur",
--     width = 22, height = 18,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"baldur", 0.4, true},
--     }
-- }

local Baldur, super = Class(Actor)

function Baldur:init()
    super:init(self)

    self.width = 22
    self.height = 18

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"baldur", 0.4, true},
    }
end

return Baldur