-- local slash = Spell{
--     id = "quickslash",
--     name = "Quick Slash",
--     effect = "Attack\nfaster",
--     description = "Concentrates soul into the user's nail, granting\nthem better control of their swings.",

--     cost = 16,

--     target = "none",
--     tags = {"attack", "wave_spell"},
-- }

-- function slash:onStart(user, target)
--     Game.battle.encounter.spells["quickslash"] = true
--     Game.battle:finishActionBy(user)
-- end

-- return slash

local Slash, super = Class(Spell)

function Slash:init()
    super:init(self)

    self.name = "Quick Slash"
    self.effect = "Attack\nfaster"
    self.description = "Concentrates soul into the user's nail, granting\nthem better control of their swings."

    self.cost = 16

    self.target = "none"
    self.tags = {"attack", "wave_spell"}
end

function Slash:onStart(user, target)
    Game.battle.encounter.spells["quickslash"] = true
    Game.battle:finishActionBy(user)
end

return Slash