local Slam, super = Class(Wave)

function Slam:init()
    super:init(self)
    self.time = 7
    self:setArenaShape({20,0}, {220,0}, {240,70}, {240,140}, {0,140}, {0,70})
end

function Slam:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p3/galien/galien", arena.x, arena.top + 30)
    self:spawnBullet("p3/galien/scythe", arena.left + 40, arena.top + 40)
    self:spawnBullet("p3/galien/blade", arena.x + 60, arena.y, Utils.random(0.3, math.pi/2 - 0.3)*Utils.randomSign())
    self:spawnBullet("p3/galien/blade", arena.x - 60, arena.y + 30, math.pi + Utils.random(0.3, math.pi/2 - 0.3)*Utils.randomSign())
end

return Slam