local Heart, super = Class("nailbase")

function Heart:init(x, y, dir)
    super:init(self, x, y, "battle/ordeal/bigzote_heart")
    self.sprite:play(0.1, true)
    self:setScale(0.5)

    self.dir = dir
    
    local timer = Timer()
    self:addChild(timer)
    timer:tween(0.1, self, {scale_x = 1, scale_y = 1})
end

function Heart:fire()
    for i=-2,2 do
        local blob = self.wave:spawnBullet("common/infection", self.x, self.y)
        blob:setLayer(self.layer - 1)
        blob.physics = {
            speed = 8,
            direction = self.dir + i*0.4,
            gravity = 0.03,
            gravity_direction = math.pi/2,
        }
    end
end

return Heart