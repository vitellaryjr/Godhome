local Bombs, super = Class(Wave)

function Bombs:init()
    super:init(self)
    self.time = 8
end

function Bombs:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(0.4, function()
        local x = arena.x + love.math.random(arena.width, SCREEN_WIDTH/2 - 50) * Utils.randomSign()
        self:spawnBullet("p5/kristalguardian/bomb_shard", x)
    end)
end

return Bombs