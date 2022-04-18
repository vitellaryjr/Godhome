local Gorb, super = Class("bossEncounter")

function Gorb:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/gorb", 540, 220))

    self.text = "* Ascend! Ascend with Gorb!"
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true
end

function Gorb:onBattleStart()
    super:onBattleStart(self)
    local bg = StandardBG({0.1, 0.1, 0.15}, {0.1, 0.1, 0.18})
    bg.size = 80
    Game.battle:addChild(bg)
    Game.battle:addChild(DreamRings({1,0.95,0.8}, 0.3, 6, 6))
end

return Gorb