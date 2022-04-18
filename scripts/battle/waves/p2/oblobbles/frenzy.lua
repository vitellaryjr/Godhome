local Frenzy, super = Class(Wave)

function Frenzy:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(240, 200)
end

function Frenzy:onStart()
    local arena = Game.battle.arena
    local o = self:spawnBullet("p2/oblobbles/oblobble", arena.left+40, love.math.random(arena.top+30, arena.top+50), true)
    o.enemy = Game.battle.enemies[1]

    Game.battle.timer:after(Utils.random(1,2), function()
        o:fire()
    end)
end

return Frenzy