-- return {
--     id = "lostkin",
--     width = 40, height = 28,

--     path = "enemies/p4/lostkin",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--     }
-- }

local LostKin, super = Class(Actor)

function LostKin:init()
    super:init(self)

    self.width = 40
    self.height = 28

    self.path = "enemies/p4/lostkin"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
    }
end

return LostKin