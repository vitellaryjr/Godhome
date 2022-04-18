-- return {
--     id = "gruzmother",
--     width = 38, height = 50,

--     path = "enemies/p1/gruzmother",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.1, true},
--         ["defeat"] = {"defeat", 1, false},
--     },
--     offsets = {
--         ["defeat"] = {2,-16}
--     }
-- }

local GruzMother, super = Class(Actor)

function GruzMother:init()
    super:init(self)

    self.width = 38
    self.height = 50

    self.path = "enemies/p1/gruzmother"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["defeat"] = {"defeat", 1, false},
    }
    self.offsets = {
        ["defeat"] = {2,-16}
    }
end

return GruzMother