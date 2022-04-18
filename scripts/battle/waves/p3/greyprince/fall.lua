local Fall, super = Class(Wave)

function Fall:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(200, 140)
end

function Fall:onStart()
    self:spawnFallingZote()
end

function Fall:spawnFallingZote(amt)
    local arena = Game.battle.arena
    self:spawnBullet("p3/greyprince/fallingZote", love.math.random(arena.left + 32, arena.right - 32), -30, amt)
end

return Fall