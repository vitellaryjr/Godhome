local Pound, super = Class(Wave)

function Pound:init()
    super:init(self)
    self.time = 7
    self:setArenaShape(unpack(Utils.pick{
        {{0,0}, {100,0}, {150,30}, {200,40}, {200,160}, {160,160}, {120,140}, {80,140}, {40,100}, {0,40}},
        {{0,80}, {50,60}, {90,20}, {140,0}, {190,0}, {200, 50}, {200, 160}, {0, 140}},
        {{0,10}, {100,0}, {140,60}, {200,140}, {200,160}, {100,160}, {80,120}, {0,40}},
        -- {{10,10}, {200,0}, {190,150}, {0,160}},
    }))
end

function Pound:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("common/arenathorns", arena)
    self.timer:everyInstant(1, function()
        local x, y = soul.x, arena:getBottom()
        local dist = love.math.random(60,80)
        if soul.x < arena.left + (dist+10) then
            x = x + dist
        elseif soul.x > arena.right - (dist+10) then
            x = x - dist
        else
            x = x + dist*Utils.randomSign()
        end
        local mtype = Utils.pick{"orange", "cyan"}
        local ps = ParticleEmitter(x, Mod:getBottomAt(arena, x), {
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