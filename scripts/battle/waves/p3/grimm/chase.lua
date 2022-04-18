local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Chase:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p3/grimm/dash", arena.left + arena.width*0.75, arena.top + arena.height*0.25)
end

return Chase