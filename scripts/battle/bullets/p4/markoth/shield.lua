local Shield, super = Class(Bullet)

function Shield:init(rad, dir)
    local x, y = rad*math.cos(dir), rad*math.sin(dir)
    super:init(self, x, y, "battle/p4/markoth/shield")
    self.sprite:play(0.2, true)
    self:setHitbox(4,1,7,21)
    self:setScale(1)
    self.rotation = dir
    self.graphics.spin = 0.07

    self.radius = rad
end

function Shield:update(dt)
    super:update(self, dt)
    self:setPosition(self.radius*math.cos(self.rotation), self.radius*math.sin(self.rotation))
end

function Shield:changeSpin()
    local ns = self.graphics.spin*-1
    self.wave.timer:tween(1, self.graphics, {spin = ns})
end

return Shield