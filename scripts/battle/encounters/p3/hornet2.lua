local Hornet, super = Class("bossEncounter")

function Hornet:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/hornet2", 540, 220))

    self.text = "* The Sentinel of Hallownest tests\nyou once more."
    self.pantheon_music = "hornet"

    self.background = false
    self.hide_world = true
end

function Hornet:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.33, 0.33, 0.34}, {0.21, 0.21, 0.25}, {0.05, 0.05, 0.06}))
    Game.battle:addChild(HornetThreads())
    Game.battle:addChild(ParticleEmitter(SCREEN_WIDTH + 50, 0, 0, SCREEN_HEIGHT, {
        layer = "above_battlers",
        color = {0.8, 0.8, 0.8},
        alpha = 0.1,
        scale_x = {6,8},
        scale_y = {1,2},
        rotation = 0.3,
        speed = {-20, -30},
        angle = 0.3,
        fade = 0.01,
        fade_after = {0,0.5},
        amount = 20,
        every = 0.1,
    }))
end

return Hornet