local Daggers, super = Class(Wave)

function Daggers:init()
    super:init(self)
    self.time = 6
    self:setArenaOffset(0, 40)
end

function Daggers:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local x, y = arena.x, arena.top - 50
    self.ps = ParticleAbsorber(x, y, {
        alpha = 0.5,
        fade_in = 0.07,
        size = {8,10},
        dist = {32,40},
        move_time = 0.4,
        ease = "in-out-quad",
        amount = {2,3},
        every = 0.15,
    })
    self:addChild(self.ps)
    local angle = -0.1
    self.timer:after(0.3, function()
        self.timer:everyInstant(0.05, function()
            self:spawnBullet("p4/purevessel/dagger", x, y, angle)
            local glow = self:spawnSprite("battle/p4/purevessel/soul_gradient", x, y)
            glow:setOrigin(0, 0.5)
            glow.rotation = angle
            glow.scale_x = 4
            glow.alpha = 0.4
            self.timer:after(0.2, function()
                glow:fadeOutAndRemove(0.05)
            end)
            angle = angle + 0.5
        end)
    end)
    self.timer:after(1.35, function()
        self.timer:everyInstant(1.24, function()
            local dagger = self:spawnBullet("p4/purevessel/dagger", x, y, Utils.angle(x, y, soul.x, soul.y))
            dagger.physics.speed = 10
            local glow = self:spawnSprite("battle/p4/purevessel/soul_gradient", x, y)
            glow:setOrigin(0, 0.5)
            glow.rotation = Utils.angle(x, y, soul.x, soul.y)
            glow.scale_x = 3
            glow.alpha = 0.4
            self.timer:after(0.2, function()
                glow:fadeOutAndRemove(0.05)
            end)
        end)
    end)
end

function Daggers:onEnd()
    self.ps:clear()
end

return Daggers