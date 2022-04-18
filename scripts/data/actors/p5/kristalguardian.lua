-- return {
--     id = "kristalguardian",
--     width = 45, height = 45,

--     path = "enemies/p5/kristalguardian",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.3, true},
--     }
-- }

local KristalGuardian, super = Class(Actor)

function KristalGuardian:init()
    super:init(self)

    self.width = 45
    self.height = 45

    self.path = "enemies/p5/kristalguardian"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.3, true},
    }
end

return KristalGuardian