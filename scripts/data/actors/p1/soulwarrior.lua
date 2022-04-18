-- return {
--     id = "soulwarrior",
--     width = 40, height = 38,

--     path = "enemies/p1/soulwarrior",
--     default = "idle",
--     animations = {
--         ["idle"] = {"idle", 0.5, true},
--     }
-- }

local SoulWarrior, super = Class(Actor)

function SoulWarrior:init()
    super:init(self)

    self.width = 40
    self.height = 38

    self.path = "enemies/p1/soulwarrior"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.5, true},
    }
end

return SoulWarrior