local Attack, super = Class(Wave)

function Attack:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(240,180)
end

function Attack:onStart()
    local arena = Game.battle.arena
    local bounce = false
    for _,enemy in ipairs(Game.battle.enemies) do
        local bullettype = Utils.pick{"roll", "bounce"}
        if bounce or bullettype == "roll" then -- only allow 1 max to be bounce
            local x, y = arena.x + love.math.random(arena.width/5, arena.width/3), love.math.random(arena.top + 40, arena.bottom - 40)
            self:spawnBullet("p4/watcherknights/roll", x, y, enemy)
        else
            bounce = true
            local x, y = love.math.random(arena.left + 40, arena.right - 40), arena.bottom - 33
            self:spawnBullet("p4/watcherknights/bounce", x, y, enemy)
        end
    end
end

return Attack