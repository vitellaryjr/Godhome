local Bombs, super = Class(Wave)

function Bombs:init()
    super:init(self)
    self.time = 4
    self:setArenaSize(200, 140)
end

function Bombs:onStart()
    local arena = Game.battle.arena
    for i=1,4 do
        local x = arena.left + i*50 - 25
        local y = love.math.random(arena.top + 40, arena.bottom - 40)
        self:spawnBullet("p3/greyprince/volatile", x, y)
    end
end

return Bombs