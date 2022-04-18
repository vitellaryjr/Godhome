local Pound, super = Class(Wave)

function Pound:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(200, 160)
end

function Pound:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("common/arenathorns", arena)
    self.timer:everyInstant(1, function()
        local x, y = soul.x, arena.bottom
        local dist = love.math.random(60,80)
        if soul.x < arena.left + (dist+10) then
            x = x + dist
        elseif soul.x > arena.right - (dist+10) then
            x = x - dist
        else
            x = x + dist*Utils.randomSign()
        end
        local mtype = Utils.pick{"orange", "cyan"}
        local ps = ParticleEmitter(x, y, {
            color = {{1,1,1}, (mtype == "orange") and {1,0.6,0} or {0,1,1}},
            size = {6,8},
            angle = -math.pi/2,
            angle_var = 0.2,
            speed = {4,6},
            fade = 0.2,
            fade_after = 0.3,
            amount = 2,
            every = 0.1,
        })
        self:addChild(ps)
        self.timer:after(0.5, function()
            ps:remove()
            Game.battle.shake = 4
            self:spawnBulletTo(Game.battle.mask, "p4/traitorlord/beam", x, y, mtype, -1)
            self:spawnBulletTo(Game.battle.mask, "p4/traitorlord/beam", x, y, mtype, 1)
        end)
    end)
end

return Pound