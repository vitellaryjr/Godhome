local UI, super = Class(Object)

function UI:init()
    super:init(self, 40, 40)
    self.layer = BATTLE_LAYERS["ui"]

    self.head = Sprite("battle/ordeal/ui_zote", 0, 0)
    self.head:setOrigin(0.5, 0.5)
    self:addChild(self.head)

    self.count = Text("0", 30, -11, 100, 100, {style = "menu"})
    self:addChild(self.count)
end

function UI:draw()
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", -20, -20, 80, 40)
    super:draw(self)
end

function UI:setCount(count)
    self.count:setText(tostring(count))
    if count >= 57 then
        self.head:setTexture("battle/ordeal/ui_zote_gold")
    end
    local mask = ColorMaskFX({1,1,1}, 0.8)
    self.head:addFX(mask)
    Game.battle.timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self.head:removeFX(mask)
    end)
end

return UI