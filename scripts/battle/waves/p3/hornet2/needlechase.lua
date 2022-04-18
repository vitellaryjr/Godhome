local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
end

function Chase:onStart()
    local arena = Game.battle.arena
    local side = Utils.pick{0, math.pi}
    local needle = self:spawnBullet("p3/hornet2/needle", arena.x + arena.width/2*math.cos(side + math.pi), arena.y, side, 2)
    self.timer:script(function(wait)
        wait(0.5)
        while true do
            needle:attack(needle.rotation, 12)
            while Game.battle:checkSolidCollision(needle) do
                wait()
            end
            while not Game.battle:checkSolidCollision(needle) do
                wait()
            end
            needle.physics.speed = 0
            needle:detach()
            local soul = Game.battle.soul
            local angle = needle.rotation - Utils.angleDiff(needle.rotation, Utils.angle(needle.x, needle.y, soul.x, soul.y))
            self.timer:tween(0.3, needle, {rotation = angle})
            wait(0.4)
        end
    end)
end

return Chase