local Vengefly, super = Class(Wave)

function Vengefly:init()
    super:init(self)

    self.time = 10
    self:setArenaSize(150)

    self.vengeflies = {}
end

function Vengefly:onStart()
    local arena = Game.battle.arena

    table.insert(self.vengeflies, self:spawnBullet("p1/vengeflyking/vengefly", arena.left + 20, arena.top + 20 + love.math.random(arena.height-40)))
    table.insert(self.vengeflies, self:spawnBullet("p1/vengeflyking/vengefly", arena.right - 20, arena.top + 20 + love.math.random(arena.height-40)))
end

return Vengefly