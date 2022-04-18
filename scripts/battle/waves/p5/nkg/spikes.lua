local Spikes, super = Class(Wave)

function Spikes:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(170, 140)
end

function Spikes:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:everyInstant(1.2, function()
        local ox = arena.x + love.math.random(-20,20)
        for i=-3,3 do
            local x = ox + i*40
            if math.abs(x - arena.x) < arena.width/2 + 8 then
                self:spawnBulletTo(Game.battle.mask, "p5/nkg/spike", x, arena.bottom)
            end
        end
    end)
end

return Spikes