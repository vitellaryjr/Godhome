local Orbs, super = Class(Wave)

function Orbs:init()
    super:init(self)
    self.time = 7
end

function Orbs:onStart()
    local arena = Game.battle.arena
    local side = Utils.randomSign()
    local angle = Vector.toPolar(-side,0)
    self.timer:everyInstant(1, function()
        side = side*-1
        angle = Vector.toPolar(-side,0)
        self:spawnBullet("common/soulorb", arena.x + arena.width*side, arena.y, 2, angle)
    end)
end

return Orbs