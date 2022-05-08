local Pickaxe, super = Class("projbase")

function Pickaxe:init(x, y, sx, sy)
    super:init(self, x, y, "battle/p5/kristalguardian/pickaxe")
    self.layer = self.layer + 10
    self.collider = CircleCollider(self, self.width/2, self.height/2, 6)
    self.graphics.spin = 0.5*Utils.sign(sx)
    self.physics = {
        speed_x = sx,
        speed_y = sy,
        gravity = 0.6,
        gravity_direction = math.pi/2,
    }
    self.hit_sfx = "player/hit_metal"
end

function Pickaxe:hit(source, damage)
    super:hit(self, source, damage)
    self.tp = self.tp*2
    self.physics = {
        speed = 15,
        direction = Utils.angle(source, self),
        gravity = 0.6,
        gravity_direction = math.pi/2,
    }
end

function Pickaxe:launchHit(battler)
    super:launchHit(self, battler)
    if battler == Game.battle:getEnemyBattler("p5/kristalguardian") and battler.health < 0 then
        self.wave.finished = true
        battler:onDefeat()
    end
end

return Pickaxe