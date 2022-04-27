local Fireball, super = Class(Bullet)

function Fireball:init(x, y, sx)
    super:init(self, x, y, "battle/p3/grimm/fireball")
    self.sprite:play(0.1, true)
    self:setRotationOriginExact(10, 6)
    self:setScale(4,4)
    self.collider = CircleCollider(self, 10, 6, 4)
    self.physics = {
        speed_x = sx,
        speed_y = -6,
        gravity = 0.8,
        gravity_direction = math.pi/2,
    }

    self.ps = ParticleEmitter(10, 6, {
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.2,0.5},
        blend = "screen",
        size = {8,32},
        angle = function(p) return self.rotation + math.pi end,
        speed = {0,1},
        fade = 0.04,
        fade_after = 0.2,
        amount = {2,3},
        every = 0.1,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    })
    self:addChild(self.ps)
end

function Fireball:update()
    super:update(self)
    self.rotation = math.atan2(self.physics.speed_y, self.physics.speed_x)
end

return Fireball