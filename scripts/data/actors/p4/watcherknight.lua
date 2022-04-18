-- return {
--     id = "watcherknight",
--     width = 40, height = 44,

--     path = "enemies/p4/watcherknights",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.4, true},
--         ["asleep"] = {"asleep", 0, false},
--     },
--     offsets = {
--         ["asleep"] = {2, -10},
--     }
-- }

local WatcherKnight, super = Class(Actor)

function WatcherKnight:init()
    super:init(self)

    self.width = 40
    self.height = 44

    self.path = "enemies/p4/watcherknights"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.4, true},
        ["asleep"] = {"asleep", 0, false},
    }
    self.offsets = {
        ["asleep"] = {2, -10},
    }
end

return WatcherKnight