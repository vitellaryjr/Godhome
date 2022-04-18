local Orbs, super = Class(Wave)

function Orbs:init()
    super:init(self)
    self.time = 6

    self.particles = {}
end

function Orbs:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:every(1.2, function()
        local x, y = love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom)
        local ps = ParticleAbsorber(x, y, {
            shape = {"circle", "arc"},
            alpha = 0.3,
            blend = "add",
            spin_var = 0.2,
            scale = {0.6,0.8},
            fade_in = 0.3,
            dist = {16,32},
            move_time = 0.5,
            ease = "out-sine",
            amount = {1,2},
            every = 0.1,
        })
        table.insert(self.particles, ps)
        Game.battle:addChild(ps)
        self.timer:after(0.6, function()
            for _,p in ipairs(ps.particles) do
                p:fadeOutAndRemove(0.005)
            end
            Utils.removeFromTable(self.particles, ps)
            ps:remove()
            self:spawnBullet("common/soulorb", x, y, 2, Utils.angle(x, y, soul.x, soul.y))
        end)
    end)
end

function Orbs:onEnd()
    for _,ps in ipairs(self.particles) do
        ps:clear()
        ps:remove()
    end
end

return Orbs