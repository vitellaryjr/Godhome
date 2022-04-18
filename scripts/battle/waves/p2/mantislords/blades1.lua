local Blades, super = Class(Wave)

function Blades:init()
    super:init(self)
    self.time = 6
end

function Blades:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    local dir = Utils.randomSign()
    self.timer:everyInstant(1.5, function()
        self:spawnBullet("p2/mantislords/scythe", arena.x + dir*arena.width, arena.top, soul.x, soul.y)
        dir = dir*-1
    end)
end

return Blades