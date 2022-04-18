local CycloneSlash, super = Class(Wave)

function CycloneSlash:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(190, 160)
end

function CycloneSlash:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p3/sly/cycloneslash", arena.right-40, arena.top+10)
end

return CycloneSlash