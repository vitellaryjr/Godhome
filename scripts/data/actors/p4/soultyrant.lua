-- return {
--     id = "soultyrant",
--     width = 54, height = 50,

--     path = "enemies/p4/soultyrant",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local SoulTyrant, super = Class(Actor)

function SoulTyrant:init()
    super:init(self)

    self.width = 54
    self.height = 50

    self.path = "enemies/p4/soultyrant"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return SoulTyrant