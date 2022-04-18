-- return {
--     id = "nkg",
--     width = 36, height = 70,

--     path = "enemies/p5/nkg",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     },
-- }

local NightmareKing, super = Class(Actor)

function NightmareKing:init()
    super:init(self)

    self.width = 36
    self.height = 70

    self.path = "enemies/p5/nkg"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return NightmareKing