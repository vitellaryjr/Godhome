local Nailsage, super = Class("bossEncounter")

function Nailsage:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/sly", 540, 220))

    self.text = "* The final Nailmaster is honored to\nchallenge you!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Nailsage:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.18, 0.12}, {0.2, 0.18, 0.1}))
    self.darkness = LightingOverlay(0.2, {1, 0.6, 0.2})
    self.darkness.lights = {
        {x = 540, y = 200, radius = 100},
    }
    Game.battle:addChild(self.darkness)
    Game.battle:addChild(SlyCandles(self.darkness))
    Game.battle:addChild(ParticleEmitter(0,0, SCREEN_WIDTH,SCREEN_HEIGHT, {
        layer = BATTLE_LAYERS["top"] - 100,
        shape = "triangle",
        color = {1,0.5,0.2},
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

return Nailsage