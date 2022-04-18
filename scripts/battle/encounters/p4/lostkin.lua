local LostKin, super = Class("bossEncounter")

function LostKin:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/lostkin", 540, 220))

    self.text = "* Lost Kin challenges you in the\nafterlife."
    self.pantheon_music = {"pantheon_d2", "pantheon_d3"}

    self.background = false
    self.hide_world = true
end

function LostKin:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.3, 0.1, 0.02}, {0.15, 0.15, 0.15}, {0.05, 0.05, 0.05}))
    Game.battle:addChild(DreamRings({1,0.4,0}, 0.2, 8, 6))
    Game.battle:addChild(KinInfection())
end

return LostKin