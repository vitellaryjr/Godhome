local Slam, super = Class(Wave)

function Slam:init()
    super:init(self)

    self.time = 7
end

function Slam:onStart()
    local arena = Game.battle.arena
    self:spawnBullet(
        "p1/gruzmother/slam",
        Utils.pick{arena.left + 30, arena.right - 30},
        love.math.random(arena.top + 30, arena.bottom - 30)
    )
end

return Slam