local HiveKnight, super = Class("bossEncounter")

function HiveKnight:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/hiveknight", 540, 220))

    self.text = "* Hive Knight comes to protect his\nqueen!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function HiveKnight:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(HiveBG())
end

return HiveKnight