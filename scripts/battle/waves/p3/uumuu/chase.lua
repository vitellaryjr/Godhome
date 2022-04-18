local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 6
end

function Chase:onStart()
    local soul = Game.battle.soul
    self.timer:every(0.4, function()
        self:spawnBullet("p3/uumuu/lightning", soul.x, soul.y, 24, 1)
    end)
end

return Chase