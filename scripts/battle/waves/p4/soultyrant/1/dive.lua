local Dives, super = Class(Wave)

function Dives:init()
    super:init(self)
    self.time = 6
end

function Dives:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.timer:script(function(wait)
        while true do
            local fake = love.math.random() < 0.5
            self:spawnBullet("p4/soultyrant/shock_dive", soul.x, arena.top - 50, fake)
            if fake then
                wait(0.6)
                self:spawnBullet("p4/soultyrant/shock_dive", soul.x, arena.top - 50, false, true)
                wait(1)
            else
                wait(1.2)
            end
        end
    end)
end

return Dives