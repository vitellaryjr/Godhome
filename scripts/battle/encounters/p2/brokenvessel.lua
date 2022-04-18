local BrokenVessel, super = Class("bossEncounter")

function BrokenVessel:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/brokenvessel", 540, 220))

    self.text = "* The Broken Vessel comes to life."
    self.pantheon_music = "pantheon_d1"

    self.background = false
    self.hide_world = true
end

function BrokenVessel:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.2, 0.14, 0.1}, {0.1, 0.1, 0.1}, {0.02, 0.02, 0.02}))
    Game.battle:addChild(VesselInfection())
end

return BrokenVessel