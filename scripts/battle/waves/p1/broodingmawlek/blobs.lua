local Blobs, super = Class(Wave)

function Blobs:init()
    super:init(self)
    self.time = 7
end

function Blobs:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p1/broodingmawlek/mouth", arena.x, arena.bottom)
    local soul = Game.battle.soul
    self.timer:every(0.6, function()
        local bullet = self:spawnBullet("common/infection", arena.left + arena.width/2, arena.bottom)
        bullet.tp = 0.16
        bullet.physics = {
            speed_x = Utils.random(2) * (soul.x < arena.x and -1 or 1),
            speed_y = -11 + Utils.random(-0.3,0.3),
            gravity = 0.4,
            gravity_direction = math.pi/2,
        }
    end)
end

return Blobs