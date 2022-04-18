local FailedChamp, super = Class("bossEncounter")

function FailedChamp:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/failedchamp", 530, 220))

    self.text = "* The ceiling breaks open!"
    self.pantheon_music = "pantheon_c"

    self.background = false
    self.hide_world = true

    self.skip_turn = false
end

function FailedChamp:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.3, 0.27, 0.15}, {0.3, 0.25, 0.15}, {0.05, 0.03, 0.01}))
    Game.battle:addChild(DreamRings({1,0.95,0.6}, 0.2, 8, 6))
    self.ps = ParticleEmitter(0, 0, SCREEN_WIDTH, 0, {
        layer = BATTLE_LAYERS["bottom"] + 200,
        shape = "square",
        color = {0.2,0.2,0},
        alpha = {0.8,0.9},
        size = {6,8},
        spin = {-0.2,0.2},
        speed_y = {4,6},
        gravity = 0.5,
        shrink = 1,
        shrink_after = 2,
        amount = 1,
        every = 0.2,
        auto = false,
    })
    Game.battle:addChild(self.ps)
end

function FailedChamp:onDialogueEnd()
    if self.skip_turn then
        Game.battle:nextTurn()
        return
    end
    super:onDialogueEnd(self)
end

function FailedChamp:spawnRocks(wave, num, speed)
    local arena = Game.battle.arena
    speed = speed or 0.2
    wave.timer:script(function(wait)
        for _=1,num do
            wave:spawnBullet("p1/falseknight/barrel", love.math.random(arena.left, arena.right), -40)
            wait(Utils.random(speed/2, speed))
        end
    end)
end

return FailedChamp