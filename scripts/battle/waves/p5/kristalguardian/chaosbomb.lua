local Bombs, super = Class(Wave)

function Bombs:init()
    super:init(self)
    self.time = 10
end

function Bombs:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(0.5, function()
        local x = arena.x + love.math.random(arena.width, SCREEN_WIDTH/2 - 50) * Utils.randomSign()
        local bombtype = Utils.pick{"laser", "shard", "pickaxe", "radiant"}
        self:spawnBullet("p5/kristalguardian/bomb_"..bombtype, x)
    end)
end

return Bombs