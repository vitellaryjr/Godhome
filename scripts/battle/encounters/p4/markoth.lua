local Markoth, super = Class("bossEncounter")

function Markoth:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/markoth", 540, 220))

    self.text = "* The moth tribe's warrior challenges\nyou."
    self.pantheon_music = {"pantheon_d1", "pantheon_d3"}

    self.background = false
    self.hide_world = true

    self.difficulty = 2
end

function Markoth:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.33, 0.33, 0.34}, {0.21, 0.21, 0.25}, {0.05, 0.05, 0.06}))
    Game.battle:addChild(DreamRings({0.8,0.9,1}, 0.2, 6, 6))
    Game.battle:addChild(MarkothRoots())
    Game.battle:addChild(AdditiveOverlay({0.03,0,0}))
end

return Markoth