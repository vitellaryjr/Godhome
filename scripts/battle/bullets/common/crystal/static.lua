local Crystal, super = Class(Bullet)

function Crystal:init(x, y, dir)
    super:init(self, x, y, "battle/p2/crystalguardian/crystal_base")
    self.rotation = dir
    self.collider = CircleCollider(self, self.width/2 - 2, self.height/2, 8)
    self.tp = 0
    self.laser_tp = 1.6

    self.only_circle = false
end

function Crystal:fire(time, instant)
    local laser = self.wave:spawnBulletTo(self, "common/crystal/laser", self.width/2, self.height/2, 8, time, instant and "firing" or "charging")
    laser.only_circle = self.only_circle
    laser.tp = self.laser_tp
end

return Crystal