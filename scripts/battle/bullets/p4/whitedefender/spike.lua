local Spike, super = Class(Bullet)

function Spike:init(x, y, dir)
    super:init(self, x, y, "battle/p4/whitedefender/spike")
    self:setHitbox(5,0,10,70)
    self:setOrigin(0.5, 1)
    self.collidable = false
    self.sprite:setScaleOrigin(0.5,1)
    self.sprite:setScale(0)
    if dir == -1 then self.flip_x = true end
end

function Spike:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.2, self.sprite, {scale_x = 1, scale_y = 1}, "linear", function()
        self.collidable = true
    end)
    self.wave.timer:after(0.7, function()
        self.collidable = false
        self.sprite:setScaleOrigin(0.5, 1)
        self.wave.timer:tween(0.2, self.sprite, {scale_x = 0, scale_y = 0}, "linear", function()
            self:remove()
        end)
    end)
end

return Spike