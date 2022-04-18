local Crawler, super = Class(Bullet)

function Crawler:init(x, y, dir, facing)
    super:init(self, x, y, "battle/p2/crystalguardian/crystal_bug")
    self:setOrigin(0, 0.5)
    self.rotation = dir
    self.scale_y = facing*2
    self.physics = {
        speed = 2,
        direction = dir + (facing*math.pi/2),
    }
    self.remove_offscreen = false
    self.laser_tp = 1.6
end

function Crawler:fire(time, instant)
    local laser = self.wave:spawnBulletTo(self, "common/crystal/laser", self.width/2, self.height/2, 8, time, instant and "firing" or "charging")
    laser.tp = self.laser_tp
end

function Crawler:every(time, vary, length)
    self.wave.timer:every(time + Utils.random(-vary, vary), function()
        self:fire(length or math.max(time-2, 0.2))
    end)
end

return Crawler