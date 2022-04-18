local Scythe, super = Class(Bullet)

function Scythe:init(x, y, dir)
    super:init(self, x, y)
    self.rotation = dir - math.pi/2
    self.physics.direction = dir
    self:setSize(60, 20)
    self:setHitbox(5,2.5,50,15)
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.2,
    }

    self.top = Sprite("battle/p2/mantislords/big_scythe_top", x, y)
    self.top:setOrigin(0.5, 0.5)
    self.top:setScale(2)
    self.top.rotation = self.rotation
    self.top.layer = self.layer + 1
    self.top:play(0.1, true)
    Game.battle:addChild(self.top)

    self.bottom = Sprite("battle/p2/mantislords/big_scythe_bottom", x, y)
    self.bottom:setOrigin(0.5, 0.5)
    self.bottom:setScale(2)
    self.bottom.rotation = self.rotation
    self.bottom.layer = self.layer - 1
    self.bottom:play(0.1, true)
    Game.battle:addChild(self.bottom)
end

function Scythe:dash(fast)
    self.physics.speed = 0.5
    self.physics.friction = fast and -0.8 or -0.5
    Game.battle.timer:after(1, function()
        self:fadeOutAndRemove()
    end)
end

function Scythe:update(dt)
    super:update(self, dt)
    self.top:setPosition(self:getPosition())
    self.top:setColor(self:getColor())
    self.bottom:setPosition(self:getPosition())
    self.bottom:setColor(self:getColor())
end

function Scythe:onRemove(parent)
    super:onRemove(self, parent)
end

return Scythe