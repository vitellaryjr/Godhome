local Ball, super = Class(Wave)

function Ball:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(160)
end

function Ball:onStart()
    self.timer:after(0.5, function()
        self.timer:everyInstant(3, function()
            self:spawnBeast()
        end)
        if Game.battle:getEnemyByID("p3/godtamer") then
            self.timer:after(1.2, function()
                self.timer:everyInstant(3, function()
                    self:spawnBullet("p3/godtamer/tamer", 480, Game.battle.soul.x, 2.3)
                end)
            end)
        end
    end)
end

function Ball:spawnBeast()
    local arena = Game.battle.arena
    local corner = Mod:openArenaCorner(arena, 30, 0.2, {side = Utils.pick{2,4}})
    local sx, sy
    if corner.side == 2 then
        sx = 1
        if corner.half == -1 then
            sy = -1
        else
            sy = 1
        end
    else
        sx = -1
        if corner.half == -1 then
            sy = 1
        else
            sy = -1
        end
    end
    self.timer:after(0.7, function()
        local x, y = arena.x + sx*arena.width, arena.y + sy*43
        local dir, grav_dir = Vector.toPolar(-sx,0), Vector.toPolar(0,sy)
        self:spawnBulletTo(Game.battle.mask, "p3/godtamer/ball", x, y, dir, grav_dir)
    end)
end

return Ball