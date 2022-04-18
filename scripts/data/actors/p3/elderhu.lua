-- return {
--     id = "elderhu",
--     width = 40, height = 35,

--     path = "enemies/p3/elderhu",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local ElderHu, super = Class(Actor)

function ElderHu:init()
    super:init(self)

    self.width = 40
    self.height = 35

    self.path = "enemies/p3/elderhu"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return ElderHu