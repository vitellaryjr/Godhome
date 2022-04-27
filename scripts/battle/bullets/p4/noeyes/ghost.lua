local Ghost, super = Class(Bullet)

function Ghost:init(x, y, dir)
    super:init(self, x, y, "battle/p4/noeyes/ghost")
    self.sprite:play(0.2, true)
    self.collider = CircleCollider(self, 32, 10, 5)
    self.scale_x = 2*dir
    self.physics.speed_x = 5*dir

    self.oy = y
    self.sine = Utils.random(math.pi*2)
end

function Ghost:update()
    super:update(self)
    self.sine = self.sine + DT
    self.y = self.oy + 36*math.sin(self.sine*4)
end

return Ghost