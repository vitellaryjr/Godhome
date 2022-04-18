local Retract, super = Class(Wave)

function Retract:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(180)
end

function Retract:onStart()
    local arena = Game.battle.arena
    local side = Utils.pick{0, math.pi}
    local needle = self:spawnBullet("p3/hornet2/needle", arena.x + arena.width/2*math.cos(side + math.pi), arena.y, side)
    self.timer:script(function(wait)
        wait(0.5)
        while true do
            local sx, sy = needle.x, needle.y
            needle:attack(needle.rotation, 20)
            needle.physics.friction = 1
            while needle.physics.speed > 0 do
                wait()
            end
            local return_speed = 0
            local return_dir = needle.rotation + math.pi
            while needle.x ~= sx or needle.y ~= sy do
                return_speed = return_speed + 1.6*DTMULT
                needle.x = Utils.approach(needle.x, sx, math.abs(return_speed*math.cos(return_dir))*DTMULT)
                needle.y = Utils.approach(needle.y, sy, math.abs(return_speed*math.sin(return_dir))*DTMULT)
                wait()
            end
            needle:detach()
            local soul = Game.battle.soul
            local angle = needle.rotation - Utils.angleDiff(needle.rotation, Utils.angle(needle.x, needle.y, soul.x, soul.y))
            self.timer:tween(0.1, needle, {rotation = angle})
            wait(0.1)
        end
    end)
end

return Retract