local Silk, super = Class(Bullet)

function Silk:init(x, y)
    super:init(self, x, y)
    self:setSize(64, 67)
    self.collider = CircleCollider(self, self.width/2, self.height/2, 28)
    self.collidable = false

    self.preview = 0
    self.preview_alpha = 0.5
    Game.battle.timer:tween(0.5, self, {preview = 32}, "out-cubic")
    Game.battle.timer:script(function(wait)
        wait(1)
        Game.battle.timer:tween(0.2, self, {preview_alpha = 0})
        self:setSprite("battle/p1/hornet/silkcircle", 0.1, true)
        self.collidable = true
        for _=1,4 do
            wait(0.2)
            self:addChild(AfterImage(self.sprite, 0.6))
        end
        Game.battle.timer:tween(0.5, self.sprite, {alpha = 0})
        wait(0.2)
        self.collidable = false
        wait(0.3)
        self:remove()
    end)
end

function Silk:draw()
    love.graphics.setColor(1,1,1, self.preview_alpha)
    love.graphics.setLineWidth(0.5)
    love.graphics.circle("line", self.width/2, self.height/2, self.preview)
    super:draw(self)
end

return Silk