local Test, super = Class(Wave)

function Test:init()
    super:init(self)

    self.time = -1
end

function Test:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p3/uumuu/ooma", arena.x, arena.bottom)
end

return Test