local Blades, super = Class(Wave)

function Blades:init()
    super:init(self)
    self.time = 8
end

function Blades:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    self.timer:everyInstant(1.5, function()
        self:spawnBullet("p2/mantislords/scythe", arena.x + arena.width, arena.top, soul.x, soul.y)
        self:spawnBullet("p2/mantislords/scythe", arena.x - arena.width, arena.top, soul.x, soul.y)
    end)
end

return Blades