local Spear, super = Class(Bullet)

function Spear:init(x, y, dir)
    super:init(self, x, y, "battle/p1/gorb/spear")
    self:setHitbox(3,2,15,1)
    self.rotation = dir
    self.alpha = 0
    self.physics = {
        speed = 6,
        friction = 0.5,
        direction = dir,
    }
    self.graphics = {
        fade_to = 1,
        fade = 0.1,
    }
    self.tp = 0.8

    Game.battle.timer:after(0.5, function()
        self.physics = {
            speed = 12,
            direction = dir,
        }
    end)
end

return Spear