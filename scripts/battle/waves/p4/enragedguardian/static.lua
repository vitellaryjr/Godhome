local Lasers, super = Class(Wave)

function Lasers:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(200, 140)
end

function Lasers:onStart()
    local arena = Game.battle.arena
    self:spawnBulletTo(Game.battle.mask, "p4/enragedguardian/cluster", arena.left + 10, arena.bottom - 10)
    self:spawnBulletTo(Game.battle.mask, "p4/enragedguardian/cluster", arena.right - 10, arena.bottom - 10)
    for i=0,3 do
        local x = arena.left + 10 + i*60
        local crystal = self:spawnBullet("common/crystal/static", x, arena.top + 16, math.pi/2 + Utils.random(-0.1,0.1))
        crystal.laser_tp = 3.2
        self.timer:after(0.1 + Utils.random(0.2), function()
            crystal:fire()
        end)
    end
    local soul = Game.battle.soul
    local aim = self:spawnBullet("common/crystal/static", arena.right, arena.y, 0)
    aim.laser_tp = 3.2
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
end

return Lasers