local NoEyes, super = Class("bossEncounter")

function NoEyes:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/noeyes", 540, 220))

    self.text = "* No Eyes tries to defend herself!"
    self.pantheon_music = "pantheon_d1"

    self.singing = Music()
    self.singing:play("no_eyes", 0)
    self.singing.source:setRelative(true)

    self.background = false
    self.hide_world = true
end

function NoEyes:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.15, 0.1}, {0.1, 0.18, 0.1}))
    Game.battle:addChild(DreamRings({1,0.95,0.8}, 0.2, 6, 6))

    self.darkness = LightingOverlay(0.4)
    self.darkness.lights = {
        {x = 540, y = 170, radius = 80},
    }
    Game.battle:addChild(self.darkness)
end

return NoEyes