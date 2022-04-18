local Seeds, super = Class(Wave)

function Seeds:init()
    super:init(self)
    self.time = 7
end

function Seeds:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(1.3, function()
        local x, y = love.math.random(arena.left+20, arena.right-20), love.math.random(arena.top+20, arena.bottom-20)
        local exp = self:spawnBullet("p2/brokenvessel/explosion", x, y)
        exp:setColor(1, 0.2, 0)
        self.timer:script(function(wait)
            for _=1,5 do
                wait(0.2)
                local dir = Utils.random(0, math.pi*2, math.pi/2)
                local dx, dy = Utils.round(math.cos(dir)), Utils.round(math.sin(dir))
                local sx, sy = arena.x + arena.width/2*dx, arena.y + arena.height/2*dy
                if sx ~= arena.x then
                    sy = love.math.random(arena.top+10, arena.bottom-10)
                else
                    sx = love.math.random(arena.left+10, arena.right-10)
                end
                self:spawnBullet("p2/brokenvessel/lightseed", sx, sy, dir, exp)
            end
            wait(1.2)
            exp:explode()
        end)
    end)
end

return Seeds