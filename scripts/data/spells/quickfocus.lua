-- local focus = Spell{
--     id = "quickfocus",
--     name = "Quick Focus",
--     effect = "Heal\nfaster",
--     description = "Focuses crystal energy into the user, allowing\nthem to heal faster.",

--     cost = 16,

--     target = "none",
--     tags = {"heal", "wave_spell"},
-- }

-- function focus:onStart(user, target)
--     Game.battle.encounter.spells["quickfocus"] = true
--     Game.battle:finishActionBy(user)
-- end

-- return focus

local Focus, super = Class(Spell)

function Focus:init()
    super:init(self)

    self.name = "Quick Focus"
    self.effect = "Heal\nfaster"
    self.description = "Focuses crystal energy into the user, allowing\nthem to heal faster."

    self.cost = 16

    self.target = "none"
    self.tags = {"heal", "wave_spell"}
end

function Focus:onStart(user, target)
    Game.battle.encounter.spells["quickfocus"] = true
    Game.battle:finishActionBy(user)
end

return Focus