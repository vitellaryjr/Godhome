local Birth, super = Class(Wave)

function Birth:init()
    super:init(self)

    self.time = -1
    self.gruzzers = {}
end

function Birth:onStart()
    local arena = Game.battle.arena
    local mother = self:spawnSprite("battle/p1/gruzmother/dead", arena.x, arena.bottom)
    mother:setOrigin(0.5,1)
    mother:setScale(2)

    self.timer:after(1, function()
        mother:play(0.15, true)
    end)
    self.timer:after(1.2, function()
        self.timer:during(0.8, function()
            mother:setPosition(love.math.random(arena.x-1, arena.x+1), love.math.random(arena.bottom-1, arena.bottom+1))
        end, function()
            mother:remove()
            Game.battle.shake = 4
            for i=1,5 do
                local angle = math.pi + i*math.pi/6
                local gruzzer = self:spawnBullet("p1/gruzmother/baby", arena.x + 12*math.cos(angle), arena.bottom - 18 + 12*math.sin(angle))
                table.insert(self.gruzzers, gruzzer)
            end
        end)
    end)
    self.timer:script(function(wait)
        wait(2.5)
        while #self.gruzzers > 0 do
            wait()
        end
        wait(1)
        local gruz = Game.battle:getEnemyByID("p1/gruzmother")
        gruz.final_done = true
        gruz:onDefeat()
        self.finished = true
    end)
end

return Birth