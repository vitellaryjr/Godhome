local Lasers, super = Class(Wave)

function Lasers:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
end

function Lasers:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local radiance = self:spawnBullet("p5/radiance/radiance", love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
    self.timer:script(function(wait)
        wait(0.4)
        while true do
            local start_angle = Utils.random(math.pi*2)
            radiance:setSprite("battle/p5/radiance/boss_angry", 0.15, true)
            for _=1,3 do
                Assets.playSound("bosses/radiance/laser_prepare", 0.3)
                for i=1,8 do
                    local angle = start_angle + i*math.pi/4
                    local laser = self:spawnBullet("p5/radiance/laser", radiance.x, radiance.y - 15, 0.2, angle)
                end
                wait(0.5)
                Assets.playSound("bosses/radiance/laser_burst", 0.3)
                start_angle = start_angle + math.pi/3 + Utils.random(-0.1, 0.1)
            end
            radiance:setSprite("battle/p5/radiance/boss", 0.3, true)
            wait(0.2)
            radiance:teleport(love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
            wait(0.7)
        end
    end)
end

return Lasers