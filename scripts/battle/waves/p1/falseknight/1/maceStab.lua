local Stab, super = Class(Wave)

function Stab:init()
    super:init(self)

    self.time = 8
    self:setArenaSize(160)
end

function Stab:onStart()
    local arena = Game.battle.arena
    local dir = Utils.randomSign()
    self.timer:everyInstant(1.5, function()
        dir = dir*-1
        self.timer:script(function(wait)
            local angle = Vector.toPolar(dir, 0)
            local x = arena.x + 2*arena.width*-dir
            local y = Game.battle.soul.y
            local mace = self:spawnBullet("p1/falseknight/mace", x, y, angle, arena.width)
            mace.alpha = 0
            self.timer:tween(0.2, mace, {alpha = 1})
            self.timer:tween(0.2, mace, {x = x - 20*dir}, "out-quad")
            wait(0.5)
            self.timer:tween(0.7, mace, {x = arena.x + (arena.width/2 + 30)*-dir}, "in-quad")
            wait(0.7)
            local s1 = self:spawnBulletTo(Game.battle.mask, "common/shockwave", arena.x - (arena.width/2)*-dir, y, 80, 60, 6)
            local s2 = self:spawnBulletTo(Game.battle.mask, "common/shockwave", arena.x - (arena.width/2)*-dir, y, 80, 60, -6)
            s1.rotation = mace.dir - (math.pi/2)
            s2.rotation = mace.dir - (math.pi/2)
            Game.battle.shake = 3
            wait(0.1)
            x = mace.x
            self.timer:tween(0.2, mace, {x = x - 20*dir, alpha = 0})
            wait(0.1)
            mace.collidable = false
            wait(0.1)
            mace:remove()
        end)
    end)
end

return Stab