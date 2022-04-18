local GruzMother, super = Class("bossEncounter")

function GruzMother:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/gruzmother", 540, 220))

    self.text = "* Gruz Mother wakes up from her nap!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function GruzMother:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
end

return GruzMother