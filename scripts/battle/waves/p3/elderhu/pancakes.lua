local Pancakes, super = Class(Wave)

function Pancakes:init()
    super:init(self)
    self.time = 5
    self:setArenaSize(200, 140)
end

function Pancakes:onStart()
    local arena = Game.battle.arena
    local l,r = -2,2
    local rings = {}
    self.timer:everyInstant(0.4, function()
        if #rings > 0 then
            for _,ring in ipairs(rings) do
                ring:launch()
            end
            rings = {}
        end
        local x1 = arena.x + l*40
        table.insert(rings, self:spawnBullet("p3/elderhu/ring", x1, arena.top - 10))
        if r ~= l then
            local x2 = arena.x + r*40
            table.insert(rings, self:spawnBullet("p3/elderhu/ring", x2, arena.top - 10))

            r = r - 1
            l = l + 1
        else
            l,r = -2,2
        end
    end)
end

return Pancakes