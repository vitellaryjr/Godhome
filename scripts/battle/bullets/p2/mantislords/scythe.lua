local Scythe, super = Class(Bullet)

function Scythe:init(x, y, sx, sy)
    super:init(self, x, y, "battle/p2/mantislords/scythe")
    self.sprite:play(0.1, true)
    self:setHitbox(7.5,2.5,25,5)
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.2,
    }

    self.physics.speed_y = (sy-y)/30
    Game.battle.timer:tween(1, self, {x = sx}, "out-quad", function()
        Game.battle.timer:tween(1, self.physics, {speed_x = 8*Utils.sign(x - self.x)}, "linear", function()
            self:fadeOutAndRemove()
        end)
    end)
end

return Scythe