local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Chase:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p5/nkg/dash", arena.x + arena.width/4 * Utils.randomSign(), arena.top + arena.height/4)
end

return Chase