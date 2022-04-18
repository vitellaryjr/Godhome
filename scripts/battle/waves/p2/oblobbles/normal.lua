local Normal, super = Class(Wave)

function Normal:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(300, 200)
end

function Normal:onStart()
    local arena = Game.battle.arena
    local oblobbles = {
        self:spawnBullet("p2/oblobbles/oblobble", arena.left+70, love.math.random(arena.top+30, arena.bottom-30), false),
        self:spawnBullet("p2/oblobbles/oblobble", arena.right-70, love.math.random(arena.top+30, arena.bottom-30), false),
    }
    for i,o in ipairs(oblobbles) do
        o.enemy = Game.battle.enemies[i]
        Game.battle.timer:after(Utils.random(1,3), function()
            o:fire()
        end)
    end
end

return Normal