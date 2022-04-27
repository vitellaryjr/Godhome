local Devilsknife, super = Class(Wave)

function Devilsknife:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Devilsknife:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    for i=1,4 do
        local angle = -math.pi/6 + i*math.pi/2
        local axe = self:spawnBullet("p5/kristalguardian/devilsaxe", arena.x, arena.y, angle, arena.width)
        self.timer:after(0.5, function()
            self.timer:tween(0.5, axe, {spinning = 1})
        end)
    end

    local aim = self:spawnBullet("common/crystal/static", arena.right + 20, arena.y, 0)
    aim.laser_tp = 1.2
    aim.layer = aim.layer + 20
    aim.rotation = Utils.angle(aim.x, aim.y, soul.x, soul.y)
    self.timer:everyInstant(2.5, function()
        self.timer:during(0.6, function()
            local to = Utils.angle(aim.x, aim.y, soul.x, soul.y)
            aim.rotation = Utils.approachAngle(aim.rotation, to, 0.05*DTMULT)
        end, function()
            aim:fire(0.25)
        end)
    end)
end

return Devilsknife