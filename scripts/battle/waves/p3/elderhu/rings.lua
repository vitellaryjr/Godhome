local Rings, super = Class(Wave)

function Rings:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(200, 140)
end

function Rings:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self:spawnBullet("p3/elderhu/elder", arena.x, arena.top + 20)
    local columns = {}
    for i=1,5 do table.insert(columns, i) end
    local elder = Game.battle:getEnemyBattler("p3/elderhu")
    local time = Utils.clampMap(elder.health, 0,elder.max_health, 0.6,1)
    self.timer:everyInstant(time, function()
        local player_column = Utils.round(soul.x - arena.left-20, 40)/40 + 1
        local banned = player_column + Utils.randomSign()
        if banned > 5 then banned = 4 end
        if banned < 1 then banned = 2 end
        local positions = Utils.pickMultiple(columns, 3, function(v) return v ~= banned end)
        local rings = {}
        for _,pos in ipairs(positions) do
            local x = arena.left + pos*40-20
            table.insert(rings, self:spawnBullet("p3/elderhu/ring", x, arena.top - 10))
        end
        self.timer:after(time*0.6, function()
            for _,ring in ipairs(rings) do
                ring:launch()
            end
        end)
    end)
end

return Rings