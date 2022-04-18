local Dung, super = Class("bossEncounter")

function Dung:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/whitedefender", 540, 220))

    self.text = "* The White Defender bursts from the\nfloor for a rematch!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Dung:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.33, 0.33, 0.36}, {0.28, 0.28, 0.32}, {0.06, 0.06, 0.1}))
    Game.battle:addChild(DreamRings({0.9,0.9,1}, 0.2, 8, 6))
    Game.battle:addChild(ParticleEmitter(0,0, SCREEN_WIDTH,SCREEN_HEIGHT, {
        layer = BATTLE_LAYERS["bottom"] + 100,
        color = {1,1,1},
        alpha = {0.2,0.3},
        blend = "add",
        size = {8,32},
        speed_y = {-0.1,-0.5},
        fade_in = 0.01,
        fade = 0.02,
        fade_after = {1,2},
        amount = {2,4},
        every = 1,
    }))
    Game.battle:addChild(DefenderDrip())
end

function Dung:onDialogueEnd()
    if self.rushing then
        Game.battle.shake = 6
        local defender = Game.battle:getEnemyByID("p4/whitedefender")
        defender:setAnimation("fury")
        Assets.playSound("bosses/dung_defender_roar", 0.8)
        Assets.playSound("bosses/dung_defender_chest_beat", 0.8)
        Game.battle.timer:after(2, function()
            super:onDialogueEnd(self)
        end)
        Game.battle.timer:after(4, function()
            defender:setAnimation("idle")
        end)
    else
        super:onDialogueEnd(self)
    end
end

return Dung