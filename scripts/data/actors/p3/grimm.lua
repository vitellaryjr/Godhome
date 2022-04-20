-- return {
--     id = "grimm",
--     width = 36, height = 70,

--     path = "enemies/p3/grimm",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--         ["bow_start"] = {"bow", 0.1, false},
--         ["bow_end"] = {"bow", 0.1, false, frames = {5,4,3,2,1}, next = "idle"},
--         ["scream"] = {"scream", 0.1, true},
--         ["scream_end"] = {"bow", 0.1, false, frames = {4,3,2,1}, next = "idle"},
--     },
--     offsets = {
--         ["bow"] = {5,0},
--         ["scream"] = {22,-20},
--     }
-- }

local Grimm, super = Class(Actor)

function Grimm:init()
    super:init(self)

    self.width = 36
    self.height = 70

    self.path = "enemies/p3/grimm"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["bow_start"] = {"bow", 0.1, false},
        ["bow_end"] = {"bow", 0.1, false, frames = {5,4,3,2,1}, next = "idle"},
        ["scream"] = {"scream", 0.1, true},
        ["scream_end"] = {"bow", 0.1, false, frames = {4,3,2,1}, next = "idle"},
    }
    self.offsets = {
        ["bow"] = {-5,0},
        ["scream"] = {-22,20},
    }
end

return Grimm