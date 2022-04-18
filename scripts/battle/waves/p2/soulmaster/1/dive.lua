local Dives, super = Class(Wave)

function Dives:init()
    super:init(self)
    self.time = 6
end

function Dives:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:every(1.5, function()
        self:spawnBullet("p2/soulmaster/shock_dive", soul.x, arena.top - 50)
    end)
end

return Dives