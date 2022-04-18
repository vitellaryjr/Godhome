local Balloon, super = Class(Bullet)

function Balloon:init(x, y)
    super:init(self, x, y, "battle/p3/grimm/balloon")
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.collider = CircleCollider(self, 20,20,15)

    local head = Sprite("battle/p5/nkg/balloon_head", 10, -5)
    self:addChild(head)
end

function Balloon:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:every(0.4, function()
        self.sprite:setScale(1.1, 1.1)
        self.wave.timer:tween(0.3, self.sprite, {scale_x = 1, scale_y = 1})
    end)
end

return Balloon