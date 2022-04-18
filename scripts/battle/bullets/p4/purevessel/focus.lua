local Focus, super = Class(Bullet)

function Focus:init(x, y, radius, time)
    super:init(self, x, y)
    self.layer = BATTLE_LAYERS["below_soul"]
    self:setScale(1)
    self.collider = CircleCollider(self, 0, 0, radius*0.8)
    self.collidable = false
    self.alpha = 0
    self.tp = 3.2

    self.radius = radius
    self.time = time
    self.fill_alpha = 0
end

function Focus:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.2, self, {alpha = 1})
    self.wave.timer:tween(self.time/2, self, {fill_alpha = 0.3})
    self.wave.timer:after(self.time, function()
        self.collidable = true
        self.fill_alpha = 1
        self.alpha = 0
        self.wave.timer:after(0.2, function()
            self.collidable = false
            self.wave.timer:tween(0.2, self, {fill_alpha = 0}, "linear", function()
                self:remove()
            end)
        end)
    end)
end

function Focus:draw()
    super:draw(self)
    love.graphics.setColor(1, 1, 1, self.fill_alpha)
    love.graphics.circle("fill", 0, 0, self.radius)
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.setLineWidth(2)
    love.graphics.circle("line", 0, 0, self.radius-1)
end

return Focus