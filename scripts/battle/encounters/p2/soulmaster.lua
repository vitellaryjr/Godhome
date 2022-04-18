local SoulMaster, super = Class("bossEncounter")

function SoulMaster:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/soulmaster", 540, 220))

    self.text = "* The ruler of the Sanctum ambushes\nyou!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function SoulMaster:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.12, 0.15, 0.2}, {0.1, 0.1, 0.18}, {0.01, 0.02, 0.04}))
    Game.battle:addChild(ParticleEmitter(0,0, SCREEN_WIDTH,SCREEN_HEIGHT, {
        layer = BATTLE_LAYERS["bottom"] + 100,
        shape = "arc",
        color = {1,1,1},
        alpha = {0.1, 0.3},
        scale = {0.8,2.4},
        blend = "add",
        spin_var = 0.02,
        speed_y = {-0.5,-1},
        fade_in = 0.01,
        fade_after = {1,3},
        fade = 0.01,
        every = 1,
        amount = {2,4},
    }))
end

return SoulMaster