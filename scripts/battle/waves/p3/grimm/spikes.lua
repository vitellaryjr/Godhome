local Spikes, super = Class(Wave)

function Spikes:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(170, 140)
end

function Spikes:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:everyInstant(1.6, function()
        local c = love.math.random(-1,1)
        local ox = arena.x + love.math.random(-20,20)
        for i=-2,2 do
            local x = ox + i*48
            if math.abs(x - arena.x) < arena.width/2 + 8 then
                local enemy
                if i == c then
                    enemy = Game.battle:getEnemyBattler("p3/grimm")
                end
                self:spawnBulletTo(Game.battle.mask, "p3/grimm/spike", x, arena.bottom, enemy)
            end
        end
    end)
end

return Spikes