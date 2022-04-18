-- return {
--     id = "nailmaster",
--     width = 80, height = 70,

--     path = "enemies/p1/nailmasters",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--         ["down"] = {"down", 1, false},
--         ["enter"] = {"enter", 0.1, true},
--     },
--     offsets = {
--         ["down"] = {0,10},
--         ["enter"] = {50,0},
--     }
-- }

local Nailmaster, super = Class(Actor)

function Nailmaster:init()
    super:init(self)

    self.width = 80
    self.height = 70

    self.path = "enemies/p1/nailmasters"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
        ["down"] = {"down", 1, false},
        ["enter"] = {"enter", 0.1, true},
    }
    self.offsets = {
        ["down"] = {0,10},
        ["enter"] = {50,0},
    }
end

return Nailmaster