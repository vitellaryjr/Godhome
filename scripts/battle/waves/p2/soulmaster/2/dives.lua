local Dives, super = Class(Wave)

function Dives:init()
    super:init(self)
    self.time = 6
end

function Dives:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:after(0.5, function()
        self:spawnBullet("p2/soulmaster/slam_dive", soul.x, arena.top - 50)
    end)
end

return Dives