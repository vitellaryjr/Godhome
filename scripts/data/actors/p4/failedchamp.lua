-- return {
--     id = "failedchamp",
--     width = 116, height = 74,

--     path = "enemies/p4/failedchamp",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.4, true},
--         ["fall"] = {"fall", 0.1, false, frames={1,2,2,2,3,4,5}},
--         ["fall_idle"] = {"fall", 0.1, false, frames={5}},
--     },
--     offsets = {
--         ["fall"] = {0, 20},
--         ["fall_idle"] = {0, 20},
--     }
-- }

local FailedChamp, super = Class(Actor)

function FailedChamp:init()
    super:init(self)

    self.width = 116
    self.height = 74

    self.path = "enemies/p4/failedchamp"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.4, true},
        ["fall"] = {"fall", 0.1, false, frames={1,2,2,2,3,4,5}},
        ["fall_idle"] = {"fall", 0.1, false, frames={5}},
    }
    self.offsets = {
        ["fall"] = {0, -20},
        ["fall_idle"] = {0, -20},
    }
end

return FailedChamp