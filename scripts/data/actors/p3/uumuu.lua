-- return {
--     id = "uumuu",
--     width = 50, height = 64,

--     path = "enemies/p3/uumuu",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--         ["vulnerable"] = {"vulnerable", 0.2, true},
--         ["hurt"] = {"vulnerable", 0.1, true},
--     },
--     offsets = {
--         ["vulnerable"] = {-8,0},
--     }
-- }

local Uumuu, super = Class(Actor)

function Uumuu:init()
    super:init(self)

    self.width = 50
    self.height = 64

    self.path = "enemies/p3/uumuu"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["vulnerable"] = {"vulnerable", 0.2, true},
        ["hurt"] = {"vulnerable", 0.1, true},
    }
    self.offsets = {
        ["vulnerable"] = {8,0},
    }
end

return Uumuu