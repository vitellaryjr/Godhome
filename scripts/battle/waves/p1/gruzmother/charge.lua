local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)

    self.time = 7
end

function Charge:onStart()
    local arena = Game.battle.arena
    self:spawnBullet(
        "p1/gruzmother/charge",
        Utils.pick{arena.left + 30, arena.right - 30},
        love.math.random(arena.top + 30, arena.bottom - 30)
    )
end

return Charge