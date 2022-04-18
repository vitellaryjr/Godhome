local Bees, super = Class(Wave)

function Bees:init()
    super:init(self)
    self.time = 7
    self:setArenaOffset(0, 40)
end

function Bees:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(0.8, function()
        local x = love.math.random(arena.left - 20, arena.right + 20)
        self:spawnBullet("p3/hiveknight/chasebee", x, -30)
        if love.math.random() < 0.5 then
            self.timer:after(Utils.random(0.1), function()
                x = love.math.random(arena.left - 20, arena.right + 20)
                self:spawnBullet("p3/hiveknight/chasebee", x, -30)
            end)
        end
    end)
end

return Bees