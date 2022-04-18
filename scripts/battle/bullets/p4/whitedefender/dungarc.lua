local Dung, super = Class(Bullet)

function Dung:init(x, y, sx)
    super:init(self, x, y, "battle/p1/dungdefender/dungball")
    self.rotation = Utils.random(2*math.pi)
    self.graphics.spin = sx/20
    self.collider = CircleCollider(self, self.width/2, self.height/2, 6)
    self.physics = {
        speed_x = sx,
        speed_y = -14,
        gravity = 0.8,
        gravity_direction = math.pi/2,
    }
    self.destroy_on_hit = true

    self.spawning = true
end

function Dung:update(dt)
    super:update(self, dt)
    if self.spawning then
        self.spawning = Game.battle:checkSolidCollision(self)
    else
        if Game.battle:checkSolidCollision(self) then
            Game.battle:addChild(ParticleEmitter(self.x, self.y, {
                shape = "circle",
                color = self.color,
                alpha = 0.3,
                rotation = {0, 2*math.pi},
                scale = 1,
                scale_var = 0.25,
                angles = {0, 2*math.pi},
                physics = {
                    speed = 4,
                    speed_var = 1,
                    friction = 0.1,
                },
                fade = 0.1,
                fade_after = 0.1,
                amount = {6,10},
            }))
            Game.battle:addChild(ParticleEmitter(self.x, self.y, {
                shape = "circle",
                color = self.color,
                alpha = 1,
                rotation = {0, 2*math.pi},
                scale = 0.8,
                scale_var = 0.1,
                angles = {0, 2*math.pi},
                physics = {
                    speed = 4,
                    speed_var = 1,
                    friction = 0.1,
                },
                shrink = 0.07,
                amount = {3,6},
            }))
            self:remove()
        end
    end
end

return Dung