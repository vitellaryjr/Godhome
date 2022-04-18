local Barb, super = Class("nailbase")

function Barb:init(x, y)
    super:init(self, x, y, "battle/p1/hornet/barb")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
    self.rotation = Utils.random(math.pi*2)
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.tp = 3.2
end

function Barb:hit(source, damage)
    if love.math.random() < 0.4 then
        self.hit_sfx = "player/hit_metal"
        super:hit(self, source, damage)
        self:addFX(ColorMaskFX({1,1,1}, 1))
        self.wave.timer:tween(0.2, self.sprite, {scale_x = 0.8, scale_y = 0.8}, "out-quad")
        self.wave.timer:after(0.4, function()
            self:setSprite("battle/p1/hornet/barb_parry")
            self.color = {1,1,1}
            self:setScale(4)
            self.collider = CircleCollider(self, self.width/2, self.height/2, 10)
            self.tp = 1.6
            self.wave.timer:after(0.2, function()
                self:fadeOutAndRemove(0.1)
            end)
        end)
    else
        super:hit(self, source, damage)
        self.physics = {
            speed = 16,
            direction = Utils.angle(source, self),
        }
        self:fadeOutAndRemove(0.2)
    end
end

return Barb