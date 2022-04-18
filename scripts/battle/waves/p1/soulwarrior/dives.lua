local Dives, super = Class(Wave)

function Dives:init()
    super:init(self)
    self.time = 8
end

function Dives:onStart()
    local arena = Game.battle.arena
    self.timer:every(1.5, function()
        self:spawnBullet("p1/soulwarrior/dive", love.math.random(arena.left+10,arena.right-10), arena.top-50)
    end)
end

return Dives