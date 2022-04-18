local SoulWarrior, super = Class("bossEncounter")

function SoulWarrior:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/soulwarrior", 540, 220))

    self.text = "* The Sanctum's warrior teleports in."
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true
end

function SoulWarrior:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.12, 0.15, 0.2}, {0.1, 0.1, 0.18}, {0.01, 0.02, 0.04}))
end

return SoulWarrior