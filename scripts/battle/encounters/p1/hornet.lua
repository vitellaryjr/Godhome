local Hornet, super = Class("bossEncounter")

function Hornet:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/hornet", 540, 220))

    self.text = "* The Protector of Hallownest\nchallenges you."
    self.pantheon_music = "hornet"

    self.background = false
    self.hide_world = true
end

function Hornet:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    Game.battle:addChild(HornetThreads())
end

return Hornet