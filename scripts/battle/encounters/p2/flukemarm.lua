local Flukemarm, super = Class("bossEncounter")

function Flukemarm:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/flukemarm", 540, 220))

    self.text = "* The Mother of flukes attacks!"
    self.pantheon_music = {"pantheon_d1", "pantheon_d2"}

    self.background = false
    self.hide_world = true
end

function Flukemarm:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.2, 0.2}, {0.1, 0.16, 0.18}, {0.02, 0.025, 0.03}))
    Game.battle:addChild(FlukemarmDrip())
end

return Flukemarm