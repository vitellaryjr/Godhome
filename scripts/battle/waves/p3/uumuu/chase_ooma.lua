local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 8
end

function Chase:onStart()
    local soul = Game.battle.soul
    self.timer:after(0.5, function()
        self.timer:everyInstant(1, function()
            self:spawnBullet("p3/uumuu/lightning", soul.x, soul.y, 24, 1)
        end)
    end)
    local arena = Game.battle.arena
    self.timer:script(function(wait)
        for i=1,love.math.random(2,3) do
            wait(Utils.random(0.5))
            self:spawnBullet("p3/uumuu/ooma", love.math.random(arena.left, arena.right), 350)
            wait(0.5)
        end
    end)
end

return Chase