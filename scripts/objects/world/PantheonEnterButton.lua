local Button, super = Class(Object)

function Button:init(x, y, text)
    super:init(self, x, y)

    self.name = text
    self.text = Text("[style:menu]"..self.name, 0, 0)
    local text_obj = love.graphics.newText(self.text:getFont(), self.name)
    self.text.x = -Utils.round(text_obj:getWidth()/2)
    self.text.layer = 1
    self.text.inherit_color = true
    self:addChild(self.text)

    self.soul = Sprite("player/heart_menu", self.text.x - 24, 8)
    self.soul:setScale(2)
    self.soul.visible = false
    self:addChild(self.soul)
end

function Button:update(dt)
    super:update(self, dt)
    for _,child in ipairs(self.children) do
        child.alpha = self.alpha
    end
end

function Button:toggleHover(on)
    self.soul.visible = on
end

return Button