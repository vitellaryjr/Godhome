local ZoteBomb, super = Class("ordeal/zotebase")

function ZoteBomb:init(x, y)
    super:init(self, x, y, "battle/ordeal/volatile_idle")
    self.collider = CircleCollider(self, 9, 11, 5)
    self.collidable = false
    self:setScale(0)
    self.health = 1
end

function ZoteBomb:onAdd(parent)
    super:onAdd(self, parent)
    local timer = Timer()
    self:addChild(timer)
    timer:tween(0.1, self, {scale_x = 2, scale_y = 2}, "linear", function()
        self.collidable = true
    end)
    timer:script(function(wait)
        wait(Utils.random(1,2.5))
        if not self.stage then return end
        self:setSprite("battle/ordeal/volatile_antic", 0.1, true)
        self.graphics.grow = 0.02
        wait(0.5)
        if not self.stage then return end
        self:explode()
    end)
end

function ZoteBomb:onDefeat()
    self:explode()
    self.collidable = false
end

function ZoteBomb:explode()
    self:addFX(ColorMaskFX({1,1,1}, 1))
    self.wave.timer:after(0.1, function()
        local exp = self.wave:spawnBullet("common/explosion", self.x, self.y, 40)
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        self.wave:increaseKillCount()
        for _,zote in ipairs(self.wave.zotes) do
            if not zote.immune and zote:collidesWith(exp) then
                zote:onDefeat()
            end
        end
        if love.math.random() < 0.01 then
            super:explode(self)
        else
            self:remove()
        end
    end)
end

return ZoteBomb