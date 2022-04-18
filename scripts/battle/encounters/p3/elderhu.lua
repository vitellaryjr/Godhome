local Elder, super = Class("bossEncounter")

function Elder:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/elderhu", 540, 220))

    self.text = "* The Elder challenges the mantises!\n... oh, and you."
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Elder:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.3, 0.3, 0.1}, {0.08, 0.18, 0.2}, {0, 0.01, 0.04}))
    Game.battle:addChild(DreamRings({1,0.9,0.4}, 0.2, 6, 6))
    Game.battle:addChild(ParticleEmitter(0,0, SCREEN_WIDTH,SCREEN_HEIGHT, {
        layer = BATTLE_LAYERS["top"],
        color = {1,1,0.2},
        alpha = {0.2,0.5},
        size = 4,
        speed = {0,0.5},
        fade_in = 0.05,
        fade = {0.01,0.05},
        fade_after = {1,2},
        amount = {3,5},
        every = 1,
    }))
end

return Elder