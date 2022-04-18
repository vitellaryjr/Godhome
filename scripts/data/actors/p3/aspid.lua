-- return {
--     id = "col_aspid",
--     width = 22, height = 20,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"aspid", 0.4, true},
--     }
-- }

local Aspid, super = Class(Actor)

function Aspid:init()
    super:init(self)

    self.width = 22
    self.height = 20

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"aspid", 0.4, true},
    }
end

return Aspid