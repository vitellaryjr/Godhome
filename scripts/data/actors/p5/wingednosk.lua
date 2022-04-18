-- return {
--     id = "wingednosk",
--     width = 60, height = 71,

--     path = "enemies/p5/wingednosk",
--     default = "transform_a",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--         ["transform_a"] = {"transform_a", 0.1, true},
--         ["transform_b"] = {"transform_b", 0.05, false},
--         ["transform_c"] = {"transform_c", 0.1, false, next = "transform_c_loop"},
--         ["transform_c_loop"] = {"transform_c", 0.1, true, frames = {2,3}},
--     },
--     offsets = {
--         ["transform_a"] = {10, -20},
--         ["transform_b"] = {10, -20},
--         ["transform_c"] =      {4, -10},
--         ["transform_c_loop"] = {4, -10},
--     }
-- }

local WingedNosk, super = Class(Actor)

function WingedNosk:init()
    super:init(self)

    self.width = 60
    self.height = 71

    self.path = "enemies/p5/wingednosk"
    self.default = "transform_a"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["transform_a"] = {"transform_a", 0.1, true},
        ["transform_b"] = {"transform_b", 0.05, false},
        ["transform_c"] = {"transform_c", 0.1, false, next = "transform_c_loop"},
        ["transform_c_loop"] = {"transform_c", 0.1, true, frames = {2,3}},
    }
    self.offsets = {
        ["transform_a"] = {10, -20},
        ["transform_b"] = {10, -20},
        ["transform_c"] =      {4, -10},
        ["transform_c_loop"] = {4, -10},
    }
end

return WingedNosk