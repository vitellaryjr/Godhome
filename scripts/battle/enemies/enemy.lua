local Enemy, super = Class(EnemyBattler)

function Enemy:init()
    super:init(self)

    self.attack = 5
    self.defense = 0

    self.dialogue = {}
    self.tired_percentage = -1
    self.waves = {}
    self.text = {}
end

function Enemy:onDefeat(damage, battler)
    self.hurt_timer = -1
    self:toggleOverlay(true)
    local mask = ColorMaskFX({1,0.3,0}, 0)
    self:addFX(mask)
    Game.battle.timer:tween(0.1, mask, {amount = 1}, "linear", function()
        Game.battle:addChild(ParticleEmitter(self.x, self.y, {
            color = {1,0.3,0},
            width = {8,16},
            height = {2,6},
            rotation = {-math.pi*3/5,-math.pi*2/5},
            angle = function(p) return p.rotation end,
            speed = {8,12},
            gravity = 0.8,
            match_rotation = true,
            shrink = 0.1,
            shrink_after = {0.3,0.8},
            amount = {8,10},
        }))
        Utils.removeFromTable(Game.battle.enemies, self)
        self:remove()
    end)
end

return Enemy