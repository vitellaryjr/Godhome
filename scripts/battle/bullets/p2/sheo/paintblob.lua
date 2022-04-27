local Blob, super = Class(Bullet)

function Blob:init(x, y)
    super:init(self, x, y, "battle/misc/shapes/circle")

    self:setScale(1, 1)

    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite:setRotationOrigin(0.5, 0.5)

    self.collider = CircleCollider(self, self.width/2, self.height/2, 6)

    self.destroy_on_hit = true
end

function Blob:update()
    super:update(self)

    local clamp_min, clamp_max = 2, 10
    if self.physics.speed and self.physics.direction then
        self.sprite.scale_x = Utils.clampMap(self.physics.speed, clamp_min,clamp_max, 1,1.5, "in-sine")
        self.sprite.scale_y = Utils.clampMap(self.physics.speed, clamp_min,clamp_max, 1,0.7, "in-sine")
        self.sprite.rotation = self.physics.direction
    else
        local x, y = self.physics.speed_x or 0, self.physics.speed_y or 0
        local len = Vector.len(x, y)
        self.sprite.scale_x = Utils.clampMap(len, clamp_min,clamp_max, 1,1.5, "in-sine")
        self.sprite.scale_y = Utils.clampMap(len, clamp_min,clamp_max, 1,0.7, "in-sine")
        self.sprite.rotation = Utils.angle(0,0, x,y)
    end
end

return Blob