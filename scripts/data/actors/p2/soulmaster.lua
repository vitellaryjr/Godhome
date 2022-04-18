-- return {
--     id = "soulmaster",
--     width = 54, height = 50,

--     path = "enemies/p2/soulmaster",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local SoulMaster, super = Class(Actor)

function SoulMaster:init()
    super:init(self)

    self.width = 54
    self.height = 50

    self.path = "enemies/p2/soulmaster"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return SoulMaster