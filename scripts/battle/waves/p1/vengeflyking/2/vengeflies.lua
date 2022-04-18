local Vengefly, super = Class(Wave)

function Vengefly:init()
    super:init(self)

    self.time = 10
    self:setArenaSize(150)

    self.vengeflies = {}
end

function Vengefly:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul

    for _=1,3 do
        local x, y = arena.x + Utils.randomSign()*(arena.width/2-20), love.math.random(arena.top + 20, arena.bottom - 20)
        local vengefly = self:spawnBullet("p1/vengeflyking/vengefly", x, y)
        vengefly.nail_tp = 1.6
        table.insert(self.vengeflies, vengefly)
    end

    self.timer:every(1.3, function()
        if #self.vengeflies > 0 and #self.vengeflies < 4 then
            local x, y = love.math.random(arena.left + 20, arena.right - 20), love.math.random(arena.top + 20, arena.bottom - 20)
            while math.abs(soul.x - x) < 30 and math.abs(soul.y - y) < 30 do
                x, y = love.math.random(arena.left + 20, arena.right - 20), love.math.random(arena.top + 20, arena.bottom - 20)
            end
            local vengefly = self:spawnBullet("p1/vengeflyking/vengefly", x, y)
            vengefly.nail_tp = 1.6
            vengefly.alpha = 0
            self.timer:tween(0.3, vengefly, {alpha = 1})
            table.insert(self.vengeflies, vengefly)
        end
    end)
end

return Vengefly