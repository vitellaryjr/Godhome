local Ring, super = Class(Bullet)

function Ring:init(radius, angle, spin)
    super:init(self, radius*math.cos(angle), radius*math.sin(angle), "battle/common/soulorb_spawn")
    self.remove_offscreen = false
    self.collidable = false
    self.sprite:play(0.05, false, function()
        self.collidable = true
        self.sprite:setAnimation{"battle/common/soulorb", 0.15, true}
    end)
    self:addChild(ParticleEmitter(self.width/2, self.height/2, {
        layer = "below_bullets",
        shape = {"circle", "arc"},
        alpha = {0.1,0.3},
        blend = "add",
        rotation = {0, 2*math.pi},
        spin_var = 0.5,
        scale = {0.6,0.8},
        angle = angle + Utils.sign(spin)*math.pi/2,
        angle_var = 0.2,
        physics = {
            speed = 4,
            speed_var = 1,
            friction = 0.2,
        },
        fade = 0.02,
        shrink = 0.1,
        shrink_after = 0.2,
        amount = {1,2},
        every = 0.1,
    }))

    self.radius = radius
    self.angle = angle
    self.spin = spin
end

function Ring:update()
    super:update(self)
    self.angle = self.angle + self.spin*DTMULT
    self:setPosition(self.radius*math.cos(self.angle), self.radius*math.sin(self.angle))
end

return Ring