local GreatSlash, super = Class(Wave)

function GreatSlash:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(140)
end

function GreatSlash:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(1.2, function()
        self:spawnBullet("p3/sly/greatslash", arena.x, arena.y, love.math.random(4))
    end)
end

return GreatSlash