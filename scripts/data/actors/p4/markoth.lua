-- return {
--     id = "markoth",
--     width = 24, height = 60,

--     path = "enemies/p4/markoth",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local Markoth, super = Class(Actor)

function Markoth:init()
    super:init(self)

    self.width = 24
    self.height = 60

    self.path = "enemies/p4/markoth"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return Markoth