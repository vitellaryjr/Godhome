local NailDrop, super = Class(Wave)

function NailDrop:init()
    super:init(self)
    self.time = 5
    self:setArenaSize(160)
    self:setArenaOffset(0,40)
end

function NailDrop:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p3/sly/fallnail", arena.x, arena.top - 50)
end

return NailDrop