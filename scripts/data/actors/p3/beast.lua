-- return {
--     id = "godtamers_monster",
--     width = 54, height = 56,

--     path = "enemies/p3/godtamer",
--     default = "idle",
--     animations = {
--         ["idle"] = {"beast", 0.2, true},
--     }
-- }

local Beast, super = Class(Actor)

function Beast:init()
    super:init(self)

    self.width = 54
    self.height = 56

    self.path = "enemies/p3/godtamer"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"beast", 0.2, true},
    }
end

return Beast