local SoulTyrant, super = Class("bossEncounter")

function SoulTyrant:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/soultyrant", 540, 220))

    self.text = "* The commander of soul has been\nchallenged!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function SoulTyrant:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.13, 0.3}, {0.25, 0.1, 0.25}, {0.05, 0, 0.1}))
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
    Game.battle:addChild(DreamRings({1,0.8,0.6}, 0.3, 8, 6))
    Game.battle:addChild(AdditiveOverlay({0.05, 0, 0.05}))
end

return SoulTyrant