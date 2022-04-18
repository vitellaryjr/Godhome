local Patterns, super = Class(Wave)

function Patterns:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(150, 150)
end

function Patterns:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(2.5, function()
        local positions = {}
        for x=-1,1 do
            for y=-1,1 do
                table.insert(positions, {x, y})
            end
        end
        local selected = Utils.pickMultiple(positions, love.math.random(3,4))
        for _,pos in ipairs(selected) do
            local x, y = arena.x + 50*pos[1], arena.y + 50*pos[2]
            self:spawnBullet("p3/uumuu/lightning", x, y, 30, 0.8, 1)
        end
    end)
    self.timer:script(function(wait)
        for i=1,love.math.random(2,3) do
            wait(Utils.random(0.5))
            self:spawnBullet("p3/uumuu/ooma", love.math.random(arena.left, arena.right), 350)
            wait(0.5)
        end
    end)
end

return Patterns