-- return {
--     id = "traitorlord",
--     width = 48, height = 56,

--     path = "enemies/p4/traitorlord",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.2, true},
--     }
-- }

local TraitorLord, super = Class(Actor)

function TraitorLord:init()
    super:init(self)

    self.width = 48
    self.height = 56

    self.path = "enemies/p4/traitorlord"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.2, true},
    }
end

return TraitorLord