local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(180)
end

function Chase:onStart()
    local arena = Game.battle.arena
    local side = Utils.pick{0, math.pi}
    local needle = self:spawnBullet("p1/hornet/needle", arena.x + arena.width/2*math.cos(side + math.pi), arena.y, side)
    self.timer:script(function(wait)
        while true do
            wait(0.5)
            needle:attack(needle.rotation)
            while Game.battle:checkSolidCollision(needle) do
                wait()
            end
            while not Game.battle:checkSolidCollision(needle) do
                wait()
            end
            needle.physics.speed = 0
            needle.lines[#needle.lines].needle = nil
            local soul = Game.battle.soul
            local angle = needle.rotation - Utils.angleDiff(needle.rotation, Utils.angle(needle.x, needle.y, soul.x, soul.y))
            self.timer:tween(0.5, needle, {rotation = angle})
        end
    end)
end

return Chase