local Mossy, super = Class("bossEncounter")

function Mossy:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/mosscharger", 540, 220))

    self.text = "* A nearby bush jumps to life!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Mossy:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.12, 0.25, 0.14}, {0.12, 0.25, 0.16}))
    Game.battle:addChild(MossGrass())
end

return Mossy