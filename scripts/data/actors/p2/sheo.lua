-- return {
--     id = "sheo",
--     width = 80, height = 70,

--     path = "enemies/p2/sheo",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--         ["raise_cyan"] = {"raise_cyan", 0.1, true},
--         ["raise_orange"] = {"raise_orange", 0.1, true},
--         ["slam_cyan"] = {"slam_cyan", 0.1, false},
--         ["slam_orange"] = {"slam_orange", 0.1, false},
--     },
--     offsets = {
--         ["raise_cyan"] = {0,30},
--         ["raise_orange"] = {0,30},
--         ["slam_cyan"] = {48,10},
--         ["slam_orange"] = {48,10},
--     }
-- }

local Sheo, super = Class(Actor)

function Sheo:init()
    super:init(self)

    self.width = 80
    self.height = 70

    self.path = "enemies/p2/sheo"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["raise_cyan"] = {"raise_cyan", 0.1, true},
        ["raise_orange"] = {"raise_orange", 0.1, true},
        ["slam_cyan"] = {"slam_cyan", 0.1, false},
        ["slam_orange"] = {"slam_orange", 0.1, false},
    }
    self.offsets = {
        ["raise_cyan"] = {0,30},
        ["raise_orange"] = {0,30},
        ["slam_cyan"] = {48,10},
        ["slam_orange"] = {48,10},
    }
end

return Sheo