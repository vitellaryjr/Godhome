local Patterns, super = Class(Wave)

function Patterns:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(150, 150)
end

function Patterns:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(1.5, function()
        local positions = {}
        for x=-1,1 do
            for y=-1,1 do
                table.insert(positions, {x, y})
            end
        end
        local selected = Utils.pickMultiple(positions, love.math.random(4,5))
        for _,pos in ipairs(selected) do
            local x, y = arena.x + 50*pos[1], arena.y + 50*pos[2]
            self:spawnBullet("p3/uumuu/lightning", x, y, 30, 0.6, 1)
        end
    end)
    local soul = Game.battle.soul
    self.timer:every(1.5, function()
        self:spawnBullet("p3/uumuu/lightning", soul.x, soul.y, 24, 0.6, 1)
    end)
end

return Patterns