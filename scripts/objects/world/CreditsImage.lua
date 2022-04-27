local Credits, super = Class(Object)

function Credits:init()
    super:init(self, 0, 0, 640, 360)
    self.layer = 2000
    self.alpha = 0
    self.fake_alpha = 0
end

function Credits:update()
    super:update(self)
    self.alpha = Utils.round(self.fake_alpha, 0.2)
end

function Credits:setSprite(texture)
    self.sprite = Sprite(texture)
    self.sprite:setScale(2)
    self.sprite.inherit_color = true
    self:addChild(self.sprite)
    return self.sprite
end

function Credits:transitionIn(texture, time)
    self:setSprite(texture)
    self.alpha = 0
    self.fake_alpha = 0
    Game.world.timer:tween(time, self, {fake_alpha = 1})
    return function() return self.alpha == 1 end
end

function Credits:transitionOut(time)
    self.alpha = 1
    self.fake_alpha = 1
    Game.world.timer:tween(time, self, {fake_alpha = 0}, "linear", function()
        self.sprite:remove()
    end)
    return function() return self.alpha == 0 end
end

return Credits