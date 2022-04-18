local Circles, super = Class(Wave)

function Circles:init()
    super:init(self)
    self.time = 8
end

function Circles:onStart()
    local arena = Game.battle.arena
    self.timer:script(function(wait)
        local start_angle = Utils.random(math.pi*2)
        local crystals = {}
        for i=1,12 do
            local angle = start_angle + i*math.pi/6
            local x, y = arena.x + math.cos(angle)*arena.width*0.7, arena.y + math.sin(angle)*arena.width*0.7
            local crystal = self:spawnBullet("common/crystal/static", x, y, angle + math.pi)
            crystal.alpha = 0
            crystal:fadeTo(1, 0.2)
            crystal.tp = 1.2
            table.insert(crystals, crystal)
        end
        wait(0.5)
        while true do
            local start_i = love.math.random(12)
            for _i=1,12 do
                local i = (start_i + _i) % 12 + 1
                local crystal = crystals[i]
                crystal:fire(0.2)
                wait(0.2)
            end
            wait(0.8)
        end
    end)
end

return Circles