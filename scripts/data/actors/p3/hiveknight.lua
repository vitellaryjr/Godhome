-- return {
--     id = "hiveknight",
--     width = 40, height = 56,

--     path = "enemies/p3/hiveknight",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.15, true},
--     }
-- }

local HiveKnight, super = Class(Actor)

function HiveKnight:init()
    super:init(self)

    self.width = 40
    self.height = 56

    self.path = "enemies/p3/hiveknight"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.15, true},
    }
end

return HiveKnight