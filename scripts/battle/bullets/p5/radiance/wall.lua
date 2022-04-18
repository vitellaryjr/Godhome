local Wall, super = Class("movement")

function Wall:init(x, dir)
    super:init(self, x, 0, "orange")
    self.layer = BATTLE_LAYERS["below_bullets"]
    self:setScale(1)
    self:setHitbox(0, 0, 8, 480)
    self.collidable = false

    self.dir = dir
    self.width = 0
end

function Wall:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.1, self, {width = 8}, "linear", function()
        self.collidable = true
    end)
    self.wave.timer:after(0.05, function()
        self.wave:spawnBullet("p5/radiance/wall", self.x + self.dir*10, self.dir, "orange")
    end)
    self.wave.timer:after(0.2, function()
        self.collidable = false
        self.wave.timer:tween(0.2, self, {width = 0}, "linear", function()
            self:remove()
        end)
    end)
end

function Wall:draw()
    super:draw(self)
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", 4 - self.width/2, 0, self.width, 480)
end

return Wall