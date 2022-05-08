local Radiance, super = Class("bossEncounter")

function Radiance:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p5/radiance", 520, 240))

    self.text = "* The Absolute Radiance, God of\nDreams, appears before you."
    self.pantheon_music = "radiance"

    self.background = false
    self.hide_world = true
end

function Radiance:onBattleStart()
    super:onBattleStart(self)
    local knight = Game:getPartyMember("knight")
    knight.health = knight.stats.health
    self.bg = StandardBG({0.3, 0.25, 0.18}, {0.3, 0.22, 0.15}, {0.08, 0.04, 0.03})
    Game.battle:addChild(self.bg)
    self.clouds_a = Sprite("battle/p5/radiance/bg_a", 0, 0)
    self.clouds_a.alpha = 0.05
    self.clouds_a.layer = BATTLE_LAYERS["above_ui"]
    Game.battle:addChild(self.clouds_a)
    self.clouds_b = Sprite("battle/p5/radiance/bg_b", 0, 0)
    self.clouds_b.alpha = 0.1
    self.clouds_b.layer = BATTLE_LAYERS["bottom"] + 15
    Game.battle:addChild(self.clouds_b)
    self.dream_ps = DreamRings({1,0.95,0.7}, 0.3, 8, 6)
    Game.battle:addChild(self.dream_ps)
    self.overlay = AdditiveOverlay({0.03,0.03,0.01})
    Game.battle:addChild(self.overlay)

    local radiance = Game.battle:getEnemyBattler("p5/radiance")
    self.glow = Sprite("enemies/p5/radiance/bg_glow", radiance.x, radiance.y - radiance.height)
    self.glow:setOrigin(0.5, 0.5)
    self.glow:setScale(2)
    self.glow.layer = BATTLE_LAYERS["below_battlers"]
    self.glow.alpha = 0.3
    self.glow.graphics.spin = -0.01
    Game.battle:addChild(self.glow)
end

function Radiance:getNextWaves()
    -- self:advancePhase(2)
    local radiance = Game.battle:getEnemyBattler("p5/radiance")
    Game.battle.timer:tween(0.3, radiance, {scale_x = 0}, "linear", function()
        radiance.scale_x = 0
    end)
    Game.battle.timer:tween(0.3, self.glow, {alpha = 0}, "linear", function()
        self.glow.alpha = 0
    end)
    if radiance.phase == 4 then
        local mask = ColorMaskFX({1,0.95,0.7}, 0)
        radiance:addFX(mask)
        Game.battle.timer:tween(0.3, mask, {amount = 1}, "linear", function()
            radiance:removeFX(mask)
            Assets.playSound("player/dream_exit")
            Game.battle:addChild(ParticleEmitter(radiance.x - radiance.width/4, radiance.y - radiance.height*2, radiance.width/2, radiance.height*2, {
                layer = "above_battlers",
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.95,0.7},
                alpha = {0.7,1},
                blend = "add",
                angle = -math.pi/2,
                spin = {-0.05, 0.05},
                speed_y = {-2,-10},
                shrink = 0.01,
                amount = 75,
            }))
        end)
    end
    return super:getNextWaves(self)
end

function Radiance:onTurnStart()
    if Game.battle.turn_count > 1 then
        local radiance = Game.battle:getEnemyBattler("p5/radiance")
        Game.battle.timer:tween(0.3, radiance, {scale_x = 2}, "linear", function()
            radiance.scale_x = 2
        end)
        Game.battle.timer:tween(0.3, self.glow, {alpha = 0.3}, "linear", function()
            self.glow.alpha = 0.3
        end)
    end
end

function Radiance:onDialogueEnd()
    local radiance = Game.battle:getEnemyBattler("p5/radiance")
    if radiance.phase == 2 then
        radiance:setAnimation("angry")
        Assets.playSound("bosses/radiance/scream_short_b")
        Game.battle.shake = 6
        Game.battle.timer:after(1, function()
            super:onDialogueEnd(self)
            radiance:setAnimation("idle")
        end)
    else
        super:onDialogueEnd(self)
    end
end

function Radiance:advancePhase(phase)
    if phase == 2 then
        self.void_grad = Sprite("enemies/p5/radiance/bg_void_gradient", 0, 480)
        self.void_grad.alpha = 0.5
        self.void_grad.layer = BATTLE_LAYERS["top"]
        Game.battle:addChild(self.void_grad)
        Game.battle.timer:tween(0.5, self.void_grad, {y = 280}, "out-quad")

        self.void_ps = ParticleEmitter(0, Game.battle.battle_ui.y + 20, 640, 40, {
            layer = "below_ui",
            shape = "circle",
            color = {0,0,0},
            alpha = {0.7,1},
            size = {6,12},
            speed_y = {-0.5,-1},
            fade = {0.01,0.05},
            fade_after = {1,2},
            shrink = {0.01,0.05},
            shrink_after = {1,2},
            amount = {6,8},
            every = 1,
        })
        Game.battle:addChild(self.void_ps)
    end
end

return Radiance