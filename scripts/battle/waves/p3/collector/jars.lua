local Jars, super = Class(Wave)

function Jars:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(240, 160)

    self.jar_enemies = {}
end

function Jars:onStart()
    local arena = Game.battle.arena
    for _,enemy in ipairs(Game.battle.enemies) do
        if enemy.id ~= "p3/collector" then
            local x = arena.x + love.math.random(40,100)*Utils.randomSign()
            local y = love.math.random(arena.top+5, arena.bottom-5)
            local bullet = self:spawnBullet("p3/collector/"..enemy.type, x, y, enemy)
            table.insert(self.jar_enemies, bullet)
        end
    end
    self.timer:everyInstant(0.5, function()
        self:spawnBullet("p3/collector/jar", love.math.random(arena.left, arena.right), -40)
    end, 2)
    self.timer:after(2, function()
        self.timer:everyInstant(1, function()
            if #self.bullets == 0 then
                self.finished = true
            end
        end)
    end)
end

function Jars:onEnd()
    for _,bullet in ipairs(self.jar_enemies) do
        if not bullet.enemy then
            Game.battle.encounter:spawnJarEnemy(bullet.type, bullet.health)
        end
    end
end

return Jars