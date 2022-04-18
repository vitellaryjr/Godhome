-- return {
--     id = "vengeflyking",
--     width = 52, height = 48,

--     path = "enemies/p1/vengeflyking",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--         ["charge"] = {"charge", 0.1, true},
--         ["hurt"] = {"hurt", 0.1, true},
--     }
-- }

local VengeflyKing, super = Class(Actor)

function VengeflyKing:init()
    super:init(self)

    self.width = 52
    self.height = 48

    self.path = "enemies/p1/vengeflyking"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["charge"] = {"charge", 0.1, true},
        ["hurt"] = {"hurt", 0.1, true},
    }
end

return VengeflyKing