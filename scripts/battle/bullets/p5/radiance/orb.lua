local Orb, super = Class(Bullet)

function Orb:init(x, y, dir, time)
    super:init(self, x, y, "battle/p5/radiance/orb")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 6)
    self.graphics.spin = 0.3
    self.physics = {
        speed_x = math.cos(dir)*4,
        speed_y = math.sin(dir)*4,
    }

    self.time = time

    Assets.playSound("bosses/radiance/orb_shoot", 0.5)
    self.ps = ParticleEmitter(self.width/2, self.height/2, {
        path = "battle/misc/dream",
        shape = {"small_a", "small_b"},
        color = {1,0.7,0.3},
        alpha = 0.5,
        blend = "add",
        rotation = {0, 2*math.pi},
        spin_var = 0.5,
        scale = {0.8,1},
        angle = function(p) return Utils.angle(0,0, -self.physics.speed_x, -self.physics.speed_y) end,
        angle_var = 0.2,
        speed = {1,2},
        friction = 0.1,
        fade = 0.01,
        shrink = 0.1,
        shrink_after = 0.2,
        amount = {1,2},
        every = 0.1,
    })
    self:addChild(self.ps)
end

function Orb:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(self.time, function()
        self.collidable = false
        self.ps:remove()
        self.wave.timer:tween(0.5, self, {scale_x = 0, scale_y = 0}, "linear", function()
            self:remove()
        end)
    end)
end

function Orb:update(dt)
    super:update(self, dt)
    local soul = Game.battle.soul
    local angle = Utils.angle(self, soul)
    self.physics.speed_x = Utils.approach(self.physics.speed_x, 10*math.cos(angle), 0.28*DTMULT)
    self.physics.speed_y = Utils.approach(self.physics.speed_y, 10*math.sin(angle), 0.28*DTMULT)
end

return Orb