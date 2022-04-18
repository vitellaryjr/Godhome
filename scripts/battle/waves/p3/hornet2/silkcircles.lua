local Circles, super = Class(Wave)

function Circles:init()
    super:init(self)

    self.time = 7
end

function Circles:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    for _=1,4 do
        local x, y = soul.x, soul.y
        while math.abs(x-soul.x) < 36 and math.abs(y-soul.y) < 36 do
            x, y = love.math.random(arena.left + 8, arena.right - 8), love.math.random(arena.top + 8, arena.bottom - 8)
        end
        self:spawnBullet("p3/hornet2/barb", x, y)
    end
    self.timer:everyInstant(1, function()
        local x, y = love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom)
        while math.abs(x - soul.x) < 32 and math.abs(y - soul.y) < 32 do
            x, y = love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom)
        end
        self:spawnBullet("p3/hornet2/silkcircle", x, y)
    end)
end

return Circles