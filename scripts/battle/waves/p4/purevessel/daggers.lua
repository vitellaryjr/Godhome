local Daggers, super = Class(Wave)

function Daggers:init()
    super:init(self)
    self.time = 6
end

function Daggers:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local side = Utils.randomSign()
    self.timer:everyInstant(0.7, function()
        self.timer:script(function(wait)
            local x, y = arena.x + arena.width*1.2*side, arena.y
            local ps = ParticleAbsorber(x, y, {
                alpha = 0.5,
                size = {8,10},
                dist = {8,16},
                move_time = 0.2,
                amount = {2,3},
                every = 0.1,
            })
            self:addChild(ps)
            wait(0.3)
            ps:remove()
            local angle = Utils.angle(x, y, soul.x, soul.y)
            for i=-3,3 do
                self:spawnBullet("p4/purevessel/dagger", x, y, angle + i*math.pi/12*side)
                local glow = self:spawnSprite("battle/p4/purevessel/soul_gradient", x, y)
                glow:setOrigin(0, 0.5)
                glow.rotation = angle + i*math.pi/12*side
                glow.scale_x = 4
                glow.alpha = 0.4
                self.timer:after(0.2, function()
                    glow:fadeOutAndRemove(0.05)
                end)
                wait(0.03)
            end
            side = side*-1
        end)
    end)
end

return Daggers