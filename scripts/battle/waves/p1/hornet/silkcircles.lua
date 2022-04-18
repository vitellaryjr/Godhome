local Circles, super = Class(Wave)

function Circles:init()
    super:init(self)

    self.time = 7
end

function Circles:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p1/hornet/silkcircle", love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom))
    self.timer:every(1.8, function()
        self:spawnBullet("p1/hornet/silkcircle", love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom))
    end)
end

return Circles