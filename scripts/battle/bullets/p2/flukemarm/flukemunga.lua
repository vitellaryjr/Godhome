local Flukemunga, super = Class(Bullet)

function Flukemunga:init(x, y, dir, side)
    super:init(self, x, y, "battle/p2/flukemarm/munga")
    self:setOrigin(0.5, 1)
    self.sprite:play(0.2, true)
    self.rotation = dir
    self.scale_y = -side*2
    self:setHitbox(5,8,30,22)
    self.physics = {
        speed = 9,
        direction = dir,
    }
    self.double_damage = true
    self:addChild(ParticleEmitter(0,20, {
        shape = "circle",
        width = 8, height = {1,3},
        rotation = dir + math.pi,
        rotation_var = 0.3,
        angle = function(p) return p.rotation end,
        shrink = 0.05,
        shrink_after = {0.1,0.2},
        speed = 6,
        friction = 0.2,
        mask = true,
        every = 0.1,
        amount = {1,2},
    }))
end

return Flukemunga