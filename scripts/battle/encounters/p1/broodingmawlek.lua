local BroodingMawlek, super = Class("bossEncounter")

function BroodingMawlek:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/broodingmawlek", 540, 220))

    self.text = "* Brooding Mawlek leaps towards you."
    self.pantheon_music = {"pantheon_d2", "pantheon_d3"}

    self.background = false
    self.hide_world = true
end

function BroodingMawlek:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    Game.battle:addChild(MawlekBodies())
end

return BroodingMawlek