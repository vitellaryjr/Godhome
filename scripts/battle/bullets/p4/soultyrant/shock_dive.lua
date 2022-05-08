local Dive, super = Class("nailbase")

function Dive:init(x, y, fake, fast)
    super:init(self, x, y, "battle/p1/soulwarrior/dive")
    self.sprite:play(0.1, true)
    self.enemy = Game.battle:getEnemyBattler("p4/soultyrant")
    self.physics = {
        speed_y = -4,
        friction = 0.5,
    }

    self.fake = fake
    self.fast = fast
end

function Dive:onAdd(parent)
    super:onAdd(self, parent)
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    self.wave.timer:tween(0.3, mask, {amount = 0})
    self.wave.timer:after(self.fast and 0.25 or 0.4, function() self.physics = {speed_y = 16} end)
    if self.fake then
        self.wave.timer:after(0.6, function()
            self:remove()
        end)
    end
end

function Dive:update()
    super:update(self)
    local arena = Game.battle.arena
    if self:collidesWith(arena.collider.colliders[3]) then
        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 80, 100, 5)
        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 80, 100, -5)
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
            layer = "below_bullets",
            shape = "arc",
            alpha = {0.5,0.6},
            blend = "add",
            rotation = {0, 2*math.pi},
            spin_var = 0.5,
            scale = 1,
            angles = -1/8*math.pi,
            angles_var = 0.2,
            physics = {
                speed = 4,
                speed_var = 1,
                friction = 0.2,
            },
            fade = 0.02,
            shrink = 0.1,
            shrink_after = 0.1,
            amount = love.math.random(2,3),
        }))
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
            layer = "below_bullets",
            shape = "arc",
            alpha = {0.5,0.6},
            blend = "add",
            rotation = {0, 2*math.pi},
            spin_var = 0.5,
            scale = 1,
            angles = -7/8*math.pi,
            angles_var = 0.2,
            physics = {
                speed = 4,
                speed_var = 1,
                friction = 0.2,
            },
            fade = 0.02,
            shrink = 0.1,
            shrink_after = 0.1,
            amount = love.math.random(2,3),
        }))
        Game.battle.shake = 4
        self:remove()
    end
end

function Dive:onDefeat()
    self.enemy.health = 5
end

return Dive