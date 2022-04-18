local Blades, super = Class(Wave)

function Blades:init()
    super:init(self)
    self.time = 8
    self:setArenaShape({0,0}, {40,0}, {40,-20}, {120,-20}, {120,0}, {160,0}, {160,200}, {0,200})
end

function Blades:onStart()
    local arena = Game.battle.arena
    self:spawnBulletTo(Game.battle.mask, "p3/godtamer/spikes", arena.left+20, arena.top+40, math.pi/2)
    self:spawnBulletTo(Game.battle.mask, "p3/godtamer/spikes", arena.right-20, arena.top+40, math.pi/2)
    self.timer:every(0.6, function()
        local blade = self:spawnBulletTo(Game.battle.mask, "p3/godtamer/blade", arena.x + love.math.random(-20,20), arena.top - 16)
        self.timer:after(0.1, function() blade:setParent(Game.battle) end)
    end)
    if Game.battle:getEnemyByID("p3/godtamer") then
        local soul = Game.battle.soul
        self.timer:every(3, function()
            local time = Utils.clampMap(soul.y, arena.top, arena.bottom, 1.5, 2.3)
            self:spawnBullet("p3/godtamer/tamer", 480, soul.x, time)
        end)
    end
end

return Blades