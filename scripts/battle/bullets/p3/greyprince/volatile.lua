local ZoteBomb, super = Class("nailbase")

function ZoteBomb:init(x, y)
    super:init(self, x, y, "battle/p3/greyprince/volatile_idle")
    self.collider = CircleCollider(self, 9, 11, 5)
    self.health = 1
end

function ZoteBomb:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        wait(Utils.random(1,2.5))
        if not self.stage then return end
        self:setSprite("battle/p3/greyprince/volatile_antic", 0.1, true)
        self.graphics.grow = 0.02
        wait(0.5)
        if not self.stage then return end
        self:explode()
    end)
end

function ZoteBomb:onDefeat()
    self:explode()
end

function ZoteBomb:explode()
    self:addFX(ColorMaskFX({1,1,1}, 1))
    self.wave.timer:after(0.1, function()
        self.wave:spawnBullet("common/explosion", self.x, self.y, 40)
        if love.math.random() < 0.001 then
            super:explode(self)
        else
            self:remove()
        end
    end)
end

return ZoteBomb