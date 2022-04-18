local Galien, super = Class("bossEncounter")

function Galien:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/galien", 540, 220))

    self.text = "* Galien challenges a fellow warrior!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Galien:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0, 0.15, 0.3}, {0, 0.05, 0.3}, {0, 0, 0.04}))
    Game.battle:addChild(DreamRings({0.8,0.7,1}, 0.2, 6, 6))
end

return Galien