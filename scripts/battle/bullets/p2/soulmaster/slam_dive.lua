local Dive, super = Class("nailbase")

function Dive:init(x, y)
    super:init(self, x, y, "battle/p1/soulwarrior/dive")
    self.sprite:play(0.1, true)
    self.enemy = Game.battle:getEnemyBattler("p2/soulmaster")
    self.physics = {
        speed_y = -4,
        friction = 0.5,
    }
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    Game.battle.timer:tween(0.3, mask, {amount = 0})
    Game.battle:addChild(ScreenFade({1,1,1}, 0.05, 0, 0.3))
    Game.battle.timer:after(0.5, function() self.physics = {speed_y = 14} end)
end

function Dive:update()
    super:update(self)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    if self.physics.speed_y <= 0 then
        self.x = soul.x
    end
    if self:collidesWith(arena.collider.colliders[3]) then
        self.wave.timer:after(0.2, function()
            self.wave:spawnBullet("p2/soulmaster/slam_dive", soul.x, arena.top - 50)
        end)
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
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