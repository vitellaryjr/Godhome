-- return {
--     id = "whitedefender",
--     width = 50, height = 60,

--     path = "enemies/p4/whitedefender",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--         ["fury"] = {"fury", 0.15, true},
--     }
-- }

local WhiteDefender, super = Class(Actor)

function WhiteDefender:init()
    super:init(self)

    self.width = 50
    self.height = 60

    self.path = "enemies/p4/whitedefender"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["fury"] = {"fury", 0.15, true},
    }
end

return WhiteDefender