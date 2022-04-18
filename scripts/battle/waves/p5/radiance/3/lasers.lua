local Lasers, super = Class(Wave)

function Lasers:init()
    super:init(self)
    self.time = 9
    self:setArenaSize(288,240)
end

function Lasers:onStart()
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
            x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
            radiance:teleport(x, y)
            wait(0.7)
        end
    end)
end

return Lasers