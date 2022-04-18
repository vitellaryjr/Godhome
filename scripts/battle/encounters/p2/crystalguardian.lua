local Guardian, super = Class("bossEncounter")

function Guardian:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/crystalguardian", 540, 220))

    self.text = "* The Crystal Guardian wakes up!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Guardian:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(CrystalBG())
    Game.battle:addChild(CrystalClusters())
end

return Guardian