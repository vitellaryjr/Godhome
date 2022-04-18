local Orbs, super = Class(Wave)

function Orbs:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)

    self.particles = {}
end

function Orbs:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("p5/radiance/radiance", love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
    self.timer:everyInstant(1.4, function()
        local x, y = love.math.random(arena.left - 50, arena.right + 50), love.math.random(arena.top - 50, arena.bottom + 50)
        while math.abs(x - soul.x) < 80 and math.abs(y - soul.y) < 80 do
            x, y = love.math.random(arena.left - 50, arena.right + 50), love.math.random(arena.top - 50, arena.bottom + 50)
        end
        local ps = ParticleAbsorber(x, y, {
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.7,0.3},
            alpha = 0.5,
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
        self:addChild(ps)
        self.timer:after(0.5, function()
            for _,p in ipairs(ps.particles) do
                p:fadeOutAndRemove(0.005)
            end
            Utils.removeFromTable(self.particles, ps)
            ps:remove()
            self:spawnBullet("p5/radiance/orb", x, y, Utils.angle(x, y, soul.x, soul.y), 2.2)
        end)
    end)
    self.timer:everyInstant(2, function()
        local dir = Utils.randomSign()
        self:spawnBullet("p5/radiance/wall", arena.x - dir*320, dir)
    end)
end

function Orbs:onEnd()
    for _,ps in ipairs(self.particles) do
        ps:clear()
        ps:remove()
    end
end

return Orbs