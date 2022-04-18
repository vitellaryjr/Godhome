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
end

return Slam