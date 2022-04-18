local PureVessel, super = Class("bossEncounter")

function PureVessel:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/purevessel", 540, 220))

    self.text = "* The Hollow Knight is prepared to\nbattle."
    self.pantheon_music = "pure_vessel"

    self.background = false
    self.hide_world = true
end

function PureVessel:onBattleStart()
    super:onBattleStart(self)
    local bg = StandardBG({0.1, 0.1, 0.1}, {0.1, 0.1, 0.1})
    bg.speed = 0.8
    bg.size = 60
    Game.battle:addChild(bg)
    Game.battle:addChild(BGChains({{0.2, 0.2, 0.2}, {0.1, 0.1, 0.1, 0.5}}, 12))
end

return PureVessel