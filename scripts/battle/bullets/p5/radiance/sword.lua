local Sword, super = Class(Bullet)

function Sword:init(x, y, dir, tilt)
    super:init(self, x, y, "battle/p5/radiance/sword")
    self:setHitbox(2,3, 20,1)
    self.rotation = dir
    self.physics = {
        speed = 6,
        friction = 1,
        match_rotation = true,
    }

    self.tilt = tilt or 0
end

function Sword:onAdd(parent)
    super:onAdd(self, parent)
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    self.wave.timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self:removeFX(mask)
    end)
end

function Sword:launch(speed)
    self.physics = {
        speed = speed or 10,
        match_rotation = true,
    }
    self.graphics.spin = self.tilt * 0.015
end

return Sword