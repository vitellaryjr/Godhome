local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 9
    self:setArenaSize(288,240)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    for x=0,arena.width/16 - 1 do
        local spike_b = self:spawnBullet("p5/radiance/spike", arena.left + x*16, arena.bottom)
        spike_b.tp = 0
        local spike_t = self:spawnBullet("p5/radiance/spike", arena.right - x*16, arena.top)
        spike_t.rotation = math.pi
        spike_t.tp = 0
    end
    local x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
    local radiance = self:spawnBullet("p5/radiance/radiance", x, y)
    self.timer:script(function(wait)
        wait(0.4)
        while true do
            local tilt = Utils.randomSign()
            local start_angle = Utils.random(math.pi*2)
            radiance:setSprite("battle/p5/radiance/boss_angry", 0.15, true)
            wait(0.2)
            for _=1,2 do
                local swords = {}
                for i=1,12 do
                    local angle = start_angle + i*math.pi/6
                    local sx, sy = radiance.x + math.cos(angle)*10, radiance.y + math.sin(angle)*10 - 15
                    local sword = self:spawnBullet("p5/radiance/sword", sx, sy, angle, tilt)
                    table.insert(swords, sword)
                    wait(0.02)
                end
                wait(0.08)
                for _,sword in ipairs(swords) do
                    sword:launch()
                end
                wait(0.1)
                start_angle = start_angle + math.pi/12
            end
            radiance:setSprite("battle/p5/radiance/boss", 0.3, true)
            x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
            while math.abs(x - soul.x) < arena.width/4 and math.abs(y - soul.y) < arena.height/4 do
                x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
            end
            radiance:teleport(x, y)
            wait(0.8)
        end
    end)
end

return Swords