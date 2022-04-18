local Pillars, super = Class(Wave)

function Pillars:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(140)
end

function Pillars:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.timer:after(0.2, function()
        self.timer:everyInstant(0.7, function()
            local x, y = soul.x, arena.bottom
            local ps = ParticleEmitter(x, y, {
                shape = "triangle",
                color = {1,0.2,0.2},
                alpha = {0.5,0.8},
                blend = "screen",
                size = {8,32},
                spin_var = 0.2,
                speed = {2,4},
                friction = 0.2,
                fade = 0.04,
                fade_after = 0.1,
                draw = function(p, orig)
                    local r, g, b = unpack(p.color)
                    local a = p.alpha
                    love.graphics.setColor(r*a, g*a, b*a)
                    orig:draw(p)
                end,
                mask = true,
                amount = {3,4},
                every = 0.1,
            })
            self:addChild(ps)
            self.timer:after(0.5, function()
                ps:clear()
                ps:remove()
                local pillar = self:spawnBulletTo(Game.battle.mask, "p5/nkg/firePillar", x)
                self.timer:after(0.5, function()
                    pillar.collidable = false
                    self.timer:tween(0.1, pillar, {scale_x = 0}, "linear", function()
                        pillar:remove()
                    end)
                end)
            end)
        end)
    end)
end

return Pillars