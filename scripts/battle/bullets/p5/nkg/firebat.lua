local Firebat, super = Class(Bullet)

function Firebat:init(x, y, dir, ty)
    super:init(self, x, y, "battle/p3/grimm/firebat")
    self.sprite:play(0.2, true)
    self:setHitbox(13, 11, 8, 2)
    self.scale_x = 2*dir
    self.physics = {
        speed_x = 10*dir
    }
    
    self.ty = ty
end

function Firebat:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.5, self, {y = self.ty}, "out-quad")
end

return Firebat