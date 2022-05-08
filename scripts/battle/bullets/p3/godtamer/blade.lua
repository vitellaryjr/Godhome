local Blade, super = Class("projbase")

function Blade:init(x, y)
    super:init(self, x, y, "battle/p3/godtamer/blade")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
    self.physics = {
        speed_x = Utils.random(-3,3),
        speed_y = 10,
    }
    if self.physics.speed_x > 0 then
        self.graphics.spin = 0.5
    else
        self.graphics.spin = -0.5
    end
end

function Blade:hit(source, damage)
    super:hit(self, source, damage)
    self.tp = self.tp*2
    self.physics = {
        speed = 15,
        direction = Utils.angle(source.x, source.y, self.x, self.y),
        gravity = 1,
        gravity_direction = math.pi/2,
    }
end

function Blade:launchHit(battler)
    super:launchHit(self, battler)
    if battler == Game.battle:getEnemyBattler("p3/beast") and battler.health < 0 then
        self.wave.finished = true
        battler:onDefeat()
    end
end

return Blade