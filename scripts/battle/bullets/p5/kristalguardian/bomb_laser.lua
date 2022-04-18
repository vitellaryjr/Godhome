local Laser, super = Class("p5/kristalguardian/bomb_base")

function Laser:init(x)
    super:init(self, x, "laser")
end

function Laser:explode()
    local soul = Game.battle.soul
    local laser = self.wave:spawnBulletTo(self, "common/crystal/laser", self.width/2, self.height/2, 0, 0.15)
    laser.rotation = Utils.angle(self, soul)
    self.physics.speed_y = 0
    self.wave.timer:after(0.75, function()
        -- laser:release(self.x, self.y)
        -- super:explode(self)
        self.sprite:remove()
        Assets.playSound("bosses/jevil_bomb", 0.8)
        self.wave.timer:after(0.8, function()
            self:remove()
        end)
    end)
end

return Laser