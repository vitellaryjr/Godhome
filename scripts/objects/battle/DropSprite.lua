local Drop, super = Class(Sprite)

function Drop:init(x, y, color)
    super:init(self, "battle/misc/shapes/circle", x, y)
    self.color = color
    self.alpha = 0.5
    self:setScale(0.5)
    self.physics = {
        speed = Utils.random(2,4),
        direction = math.pi/2,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    Game.battle.timer:after(2, function() self:remove() end)
end

function Drop:update()
    super:update(self)
    self.scale_x = Utils.clampMap(self.physics.speed, 2,12, 0.5,0.3, "in-sine")
    self.scale_y = Utils.clampMap(self.physics.speed, 2,12, 0.5,1, "in-sine")
end

return Drop