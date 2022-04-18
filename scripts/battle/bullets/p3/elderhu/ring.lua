local Ring, super = Class(Bullet)

function Ring:init(x, y)
    super:init(self, x, y, "battle/p3/elderhu/ring")
    self.physics = {
        speed_y = -6,
        friction = 1,
    }
end

function Ring:onAdd(parent)
    super:onAdd(self, parent)
    self.mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(self.mask)
    self.wave.timer:tween(0.4, self.mask, {amount = 0})
    local r1 = Sprite("battle/p3/elderhu/ring", 9, -1)
    r1:setOrigin(0.5, 0.5)
    r1.layer = 1
    r1.physics = {
        speed_y = 1,
        friction = 0.25,
    }
    r1.mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(r1.mask)
    self.wave.timer:tween(0.4, r1.mask, {amount = 0})
    self:addChild(r1)
    local r2 = Sprite("battle/p3/elderhu/ring", 9, -7)
    r2:setOrigin(0.5, 0.5)
    r2.layer = 2
    r2.physics = {
        speed_y = 2,
        friction = 0.5,
    }
    r2.mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(r2.mask)
    self.wave.timer:tween(0.4, r2.mask, {amount = 0})
    self:addChild(r2)
end

function Ring:launch()
    self.physics = {
        speed_y = 18,
    }
    self.wave.timer:script(function(wait)
        while self.stage do
            wait(0.02)
            Game.battle:addChild(AfterImage(self.sprite, 0.4))
        end
    end)
    self.wave.timer:script(function(wait)
        while self.y < Game.battle.arena.bottom-4 do
            wait()
        end
        self:remove()
    end)
end

return Ring