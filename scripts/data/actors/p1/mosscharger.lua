-- return {
--     id = "mossy",
--     width = 74, height = 44,

--     path = "enemies/p1/mosscharger",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.15, true},
--     }
-- }

local MossCharger, super = Class(Actor)

function MossCharger:init()
    super:init(self)

    self.width = 74
    self.height = 44

    self.path = "enemies/p1/mosscharger"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.15, true},
    }
end

return MossCharger