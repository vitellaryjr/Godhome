-- return {
--     id = "oblobble",
--     width = 50, height = 50,

--     path = "enemies/p2/oblobbles",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local Oblobble, super = Class(Actor)

function Oblobble:init()
    super:init(self)

    self.width = 50
    self.height = 50

    self.path = "enemies/p2/oblobbles"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return Oblobble