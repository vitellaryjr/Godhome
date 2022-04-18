local Dive, super = Class("nailbase")

function Dive:init(x, y)
    super:init(self, x, y, "battle/p1/soulwarrior/dive")
    self.sprite:play(0.1, true)
    self.enemy = Game.battle:getEnemyByID("p4/soultyrant")
    self.physics = {
        speed_y = -4,
        friction = 0.5,
    }
end

function Dive:onAdd(parent)
    super:onAdd(self, parent)
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    self.wave.timer:tween(0.3, mask, {amount = 0})
    self.wave.timer:after(0.3, function() self.physics = {speed_y = 16} end)
end

function Dive:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    if self.physics.speed_y <= 0 then
        self.x = soul.x
    end
    if self:collidesWith(arena.collider.colliders[3]) then
        self.wave.timer:after(0.2, function()
            self.wave:spawnBullet("p4/soultyrant/slam_dive", soul.x, arena.top - 50)
        end)
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
    self.wave.finished = true
    super:onDefeat(self)
end

return Dive