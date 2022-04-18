-- return {
--     id = "col_primal_aspid",
--     width = 22, height = 20,

--     path = "enemies/p3/collector",
--     default = "idle",
--     animations = {
--         ["idle"] = {"primal_aspid", 0.3, true},
--     }
-- }

local PrimalAspid, super = Class(Actor)

function PrimalAspid:init()
    super:init(self)

    self.width = 22
    self.height = 20

    self.path = "enemies/p3/collector"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"primal_aspid", 0.3, true},
    }
end

return PrimalAspid