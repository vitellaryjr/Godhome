-- return {
--     id = "xero",
--     width = 50, height = 48,

--     path = "enemies/p2/xero",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.15, true},
--     }
-- }

local Xero, super = Class(Actor)

function Xero:init()
    super:init(self)

    self.width = 50
    self.height = 48

    self.path = "enemies/p2/xero"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.15, true},
    }
end

return Xero