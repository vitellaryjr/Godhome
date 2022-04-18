local MoveBullet, super = Class(Bullet)

function MoveBullet:init(x, y, type, texture)
    super:init(self, x, y, texture)
    self.tp = 0
    if type == "orange" then
        self.type = "orange"
        self.color = {1, 0.6, 0}
    else
        self.type = "cyan"
        self.color = {0, 1, 1}
    end
    self.override = false
end

function MoveBullet:onCollide(soul)
    if self.type == "cyan"   and (soul.moving_x ~= 0 or  soul.moving_y ~= 0)
    or self.type == "orange" and (soul.moving_x == 0 and soul.moving_y == 0)
    or self.override then
        super:onCollide(self, soul)
    end
end

return MoveBullet