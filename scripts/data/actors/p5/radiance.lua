-- return {
--     id = "radiance",
--     width = 69, height = 78,

--     path = "enemies/p5/radiance",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.15, true},
--         ["angry"] = {"angry", 0.15, true},
--         ["shake"] = {"defeat", 0.15, true},
--         ["light"] = {"defeat_light", 0.1, true},
--         ["light_final"] = {"defeat_light_final", 0.1, true},
--     },
--     offsets = {
--         ["defeat"] = {-5,-14},
--         ["defeat_light"] = {-5,-14},
--         ["defeat_light_final"] = {-5,-14},
--     }
-- }

local Radiance, super = Class(Actor)

function Radiance:init()
    super:init(self)

    self.width = 69
    self.height = 78

    self.path = "enemies/p5/radiance"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.15, true},
        ["angry"] = {"angry", 0.15, true},
        ["shake"] = {"defeat", 0.15, true},
        ["light"] = {"defeat_light", 0.1, true},
        ["light_final"] = {"defeat_light_final", 0.1, true},
    }
    self.offsets = {
        ["defeat"] = {5,14},
        ["defeat_light"] = {5,14},
        ["defeat_light_final"] = {5,14},
    }
end

return Radiance