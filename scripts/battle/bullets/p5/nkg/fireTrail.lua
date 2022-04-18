local Trail, super = Class(Bullet)

function Trail:init(x, y, rot)
    super:init(self, x, y, "battle/p3/grimm/fireball")
    self.layer = self.layer - 10
    self.sprite:play(0.1, true)
    self.collider = CircleCollider(self, 10, 6, 4)
    self.rotation = rot
    self.color = {1,0.2,0.2}
    self.alpha = 0.8

    self.ps = ParticleEmitter(10, 6, {
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.2,0.5},
        blend = "screen",
        size = {8,16},
        speed = {1,2},
        friction = {0,0.02},
        fade = 0.04,
        fade_after = 0.2,
        amount = {2,3},
        every = 0.2,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    })
    self:addChild(self.ps)
end

function Trail:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(1, function()
        self.collidable = false
        self.ps:remove()
        self:fadeOutAndRemove(0.1)
    end)
end

function Trail:draw()
    local r, g, b = unpack(self.color)
    local a = self.alpha
    love.graphics.setColor(r*a, g*a, b*a)
    love.graphics.setBlendMode("screen")
    super:draw(self)
    love.graphics.setBlendMode("alpha")
end

return Trail