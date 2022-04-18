local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local radiance = self:spawnBullet("p5/radiance/radiance", love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
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
                    local x, y = radiance.x + math.cos(angle)*10, radiance.y + math.sin(angle)*10 - 15
                    local sword = self:spawnBullet("p5/radiance/sword", x, y, angle, tilt)
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
            radiance:teleport(love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
            wait(0.7)
        end
    end)
end

return Swords