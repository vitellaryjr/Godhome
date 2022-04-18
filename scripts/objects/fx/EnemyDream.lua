local Dream, super = Class(Object)

function Dream:init(x, y)
    super:init(self, x, y)
    self.sprite = Sprite("battle/misc/dream/small_"..Utils.pick{"a","b"}, 0, 0)
    self.sprite:setOrigin(0.5,0.5)
    self.sprite.rotation = Utils.random(2*math.pi)
    self.sprite.inherit_color = true
    self:addChild(self.sprite)
    self.layer = BATTLE_LAYERS["above_battlers"]

    self.physics = {
        speed_y = Utils.random(-0.4,-0.6)
    }
    self.sprite.graphics = {
        spin = Utils.random(-0.05,0.05)
    }

    self.timer = Timer()
    self:addChild(self.timer)

    self.timer:after(Utils.random(0.8,1.2), function()
        self:fadeOutAndRemove(Utils.random(0.02,0.04))
    end)
end

return Dream