local Retract, super = Class(Wave)

function Retract:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(180)
end

function Retract:onStart()
    local arena = Game.battle.arena
    local side = Utils.pick{0, math.pi}
    local needle = self:spawnBullet("p1/hornet/needle", arena.x + arena.width/2*math.cos(side + math.pi), arena.y, side)
    self.timer:script(function(wait)
        wait(0.5)
        while true do
            local sx, sy = needle.x, needle.y
            needle:attack(needle.rotation, 15)
            needle.physics.friction = 0.65
            while needle.physics.speed > 0 do
                wait()
            end
            local return_speed = 0
            local return_dir = needle.rotation + math.pi
            while needle.x ~= sx or needle.y ~= sy do
                return_speed = return_speed + 0.8*DTMULT
                needle.x = Utils.approach(needle.x, sx, math.abs(return_speed*math.cos(return_dir))*DTMULT)
                needle.y = Utils.approach(needle.y, sy, math.abs(return_speed*math.sin(return_dir))*DTMULT)
                wait()
            end
            needle.lines[#needle.lines].needle = nil
            local soul = Game.battle.soul
            local angle = needle.rotation - Utils.angleDiff(needle.rotation, Utils.angle(needle.x, needle.y, soul.x, soul.y))
            self.timer:tween(0.3, needle, {rotation = angle})
            wait(0.6)
        end
    end)
end

return Retract