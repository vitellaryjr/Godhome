local VengeflyKing, super = Class("bossEncounter")

function VengeflyKing:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/vengeflyking", 540, 220))

    self.text = "* The Vengefly King swoops in!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true

    self.seen_charge = false
end

function VengeflyKing:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
end

return VengeflyKing