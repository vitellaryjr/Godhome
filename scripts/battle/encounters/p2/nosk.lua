local Nosk, super = Class("bossEncounter")

function Nosk:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/nosk", 540, 220))

    self.text = "* Nosk traps you in its arena!"
    self.pantheon_music = {"pantheon_d1", "pantheon_d2", "pantheon_d3"}

    self.background = false
    self.hide_world = true
end

function Nosk:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.1, 0.15}, {0.1, 0.1, 0.18}))
    Game.battle:addChild(NoskThreads())

    self.darkness = LightingOverlay((self.difficulty > 1) and 0.7 or 0.3)
    self.darkness.lights = {
        {x = 540, y = 180, radius = 100},
    }
    Game.battle:addChild(self.darkness)
end

return Nosk