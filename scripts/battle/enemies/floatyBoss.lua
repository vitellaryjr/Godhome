local FloatyBoss, super = Class("boss")

function FloatyBoss:init()
    super:init(self)

    self.sine = 0
    self.float_height = 4
    self.float_speed = 0.05
end

function FloatyBoss:update(dt)
    super:update(self, dt)
    self.sine = self.sine + self.float_speed*DTMULT
    self.sprite.y = math.sin(self.sine)*self.float_height
    self.overlay_sprite.y = math.sin(self.sine)*self.float_height
end

return FloatyBoss