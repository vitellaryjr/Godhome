local Marmu, super = Class("bossEncounter")

function Marmu:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/marmu", 540, 220))

    self.text = "* Marmu eagerly plays with you!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Marmu:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.12, 0.25, 0.14}, {0.12, 0.25, 0.16}, {0, 0.05, 0.04}))
    Game.battle:addChild(DreamRings({1,0.95,0.8}, 0.3, 6, 6))
end

return Marmu