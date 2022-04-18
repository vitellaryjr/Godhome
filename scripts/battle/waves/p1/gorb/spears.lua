local Spears, super = Class(Wave)

function Spears:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(180)
end

function Spears:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p1/gorb/gorb", arena.x, arena.top + 20)
end

return Spears