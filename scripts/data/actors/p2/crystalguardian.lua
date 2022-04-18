-- return {
--     id = "crystalguardian",
--     width = 45, height = 45,

--     path = "enemies/p2/crystalguardian",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.35, true},
--     }
-- }

local CrystalGuardian, super = Class(Actor)

function CrystalGuardian:init()
    super:init(self)

    self.width = 45
    self.height = 45

    self.path = "enemies/p2/crystalguardian"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.35, true},
    }
end

return CrystalGuardian