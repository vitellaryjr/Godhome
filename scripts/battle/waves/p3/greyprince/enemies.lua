local Enemies, super = Class(Wave)

function Enemies:init()
    super:init(self)
    self.time = 10
    self:setArenaSize(180, 140)

    self.enemies = {}
end

function Enemies:onStart()
    local arena = Game.battle.arena
    self.timer:script(function(wait)
        for _=1,3 do
            wait(0.5)
            local x, y = love.math.random(arena.left + 12, arena.right - 12), arena.top
            self:spawnBulletTo(Game.battle.mask, "p3/greyprince/spawnzote", x, y)
        end
    end)
end

return Enemies