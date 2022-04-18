local Lasers, super = Class(Wave)

function Lasers:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(200, 140)
end

function Lasers:onStart()
    local arena = Game.battle.arena
    for i=0,2 do
        local x = arena.left + 10 + i*90
        local crystal = self:spawnBullet("common/crystal/static", x, arena.top + 16, math.pi/2 + Utils.random(-0.1,0.1))
        crystal.laser_tp = 1.2
        self.timer:after(Utils.random(0.2), function()
            crystal:fire()
        end)
    end
    local soul = Game.battle.soul
    local aim = self:spawnBullet("common/crystal/static", arena.right, arena.y, 0)
    aim.laser_tp = 1.2
    aim.layer = aim.layer + 20
    aim.rotation = Utils.angle(aim.x, aim.y, soul.x, soul.y)
    self.timer:everyInstant(2, function()
        self.timer:during(0.6, function(dt)
            local to = Utils.angle(aim.x, aim.y, soul.x, soul.y)
            aim.rotation = Utils.approachAngle(aim.rotation, to, 0.05*DTMULT)
        end, function()
            aim:fire(0.2)
        end)
    end)

    local conv_dir = Utils.random(0, math.pi*2, math.pi/2)
    self.conveyor = ArenaConveyor(1.5, conv_dir, 200)
    Game.battle.mask:addChild(self.conveyor)
    self.timer:every(1, function()
        -- spawn a tiny shard along the edge of the arena depending on the conveyor direction
        local x, y = arena.x - (arena.width/2 + 10)*math.cos(conv_dir), arena.y - (arena.height/2 + 10)*math.sin(conv_dir)
        local is_hori = x == arena.x
        if is_hori then
            x = love.math.random(arena.left, arena.right)
        else
            y = love.math.random(arena.top, arena.bottom)
        end
        local crystal = self:spawnBulletTo(Game.battle.mask, "p5/kristalguardian/tiny_shard", x, y)
        self.conveyor:addShard(crystal)
    end)
end

function Lasers:onEnd()
    self.conveyor:remove()
end

return Lasers