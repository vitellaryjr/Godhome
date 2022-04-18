local Bomb, super = Class(Bullet)

function Bomb:init(x, texture)
    super:init(self, x, -24, "battle/p5/kristalguardian/bomb_"..texture)
    self.sprite:play(0.1, true)
    self.physics.speed_y = 10
end

function Bomb:onAdd(parent)
    super:onAdd(self, parent)
    self.time = self.time or Utils.random(0.5, 1)
    self.wave.timer:after(self.time, function()
        self:explode()
    end)
end

function Bomb:explode()
    Assets.playSound("bosses/jevil_bomb", 0.8)
    self:remove()
end

return Bomb