local Thread, super = Class(Bullet)

function Thread:init(needle)
    super:init(self, needle.x, needle.y)
    self:setOrigin(0, 0)
    self:setScale(1)
    self.collider = LineCollider(self, 0,0, 0,0)
    self.tp = 0.8

    self.needle = needle
end

function Thread:update(dt)
    super:update(self, dt)
    if self.needle then
        self.collider.x2 = self.needle.x - self.x
        self.collider.y2 = self.needle.y - self.y
    end
end

function Thread:draw()
    super:draw(self)
    self.collider:draw(1,1,1, self.alpha)
end

return Thread