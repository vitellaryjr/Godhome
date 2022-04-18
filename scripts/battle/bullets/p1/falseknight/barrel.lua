local Barrel, super = Class("projbase")

function Barrel:init(x, y)
    super:init(self, x, y, "battle/p1/falseknight/barrel")
    self:setHitbox(3,3,8,12)
    self.rotation = Utils.random(2*math.pi)

    self.physics.speed_y = 6
    self.graphics.spin = Utils.random(0.05,0.1)*Utils.randomSign()
end

function Barrel:hit(source, damage)
    super:hit(self, source, damage)
    local angle = Utils.angle(source.x, source.y, self.x, self.y)
    if math.cos(angle) > 0 then
        angle = Utils.approachAngle(angle, 0, 0.5)
        self.graphics.spin = 0.5
    else
        angle = Utils.approachAngle(angle, math.pi, 0.5)
        self.graphics.spin = -0.5
    end
    self.physics = {
        speed = 20,
        direction = angle
    }
end

function Barrel:launchHit(battler)
    super:launchHit(self, battler)
    self:remove()
end

return Barrel