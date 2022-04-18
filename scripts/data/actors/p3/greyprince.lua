-- return {
--     id = "gpz",
--     width = 42, height = 50,

--     path = "enemies/p3/greyprince",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.3, true},
--     }
-- }

local GreyPrince, super = Class(Actor)

function GreyPrince:init()
    super:init(self)

    self.width = 42
    self.height = 50

    self.path = "enemies/p3/greyprince"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.3, true},
    }
end

return GreyPrince