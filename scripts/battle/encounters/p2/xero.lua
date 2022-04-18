local Xero, super = Class("bossEncounter")

function Xero:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/xero", 540, 220))

    self.text = "* Here lies the traitor."
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Xero:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.12, 0.2}, {0.1, 0.1, 0.18}, {0.02, 0.025, 0.03}))
    Game.battle:addChild(DreamRings({0.8,1,1}, 0.2, 8, 6))
    Game.battle:addChild(XeroGraves())
end

return Xero