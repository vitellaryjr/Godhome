local Focus, super = Class(Wave)

function Focus:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Focus:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.timer:everyInstant(2, function()
        self:spawnBullet("p4/purevessel/focus", soul.x, soul.y, 60, 1)
        self.timer:after(0.8, function()
            Game.battle:addChild(ScreenFade({1,1,1}, 0.1, 0, 0.2))
            Game.battle.shake = 3
        end)
        self.timer:script(function(wait)
            wait(1)
            local angle = Utils.random(math.pi*2)
            local dist = Utils.random(40, 80)
            for i=1,4 do
                self:spawnBullet("p4/purevessel/focus", arena.x + dist*math.cos(angle + i*math.pi/2), arena.y + dist*math.sin(angle + i*math.pi/2), 40, 0.7)
                wait(0.15)
            end
        end)
    end)
end

return Focus