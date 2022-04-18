local Dung, super = Class("p1/dungdefender/bounce")

function Dung:init(x, y, dir)
    super:init(self, x, y, dir, "battle/p1/dungdefender/dungball")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 6)
    self.health = 30
end

function Dung:onDefeat()
    Game.battle:addChild(ParticleEmitter(self.x, self.y, {
        shape = "circle",
        color = {1, 0.8, 0.5},
        alpha = 0.5,
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
        color = {1, 0.8, 0.5},
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
    super:onDefeat(self)
end

return Dung