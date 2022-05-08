local Menu, super = Class(Object)

function Menu:init(statue)
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.alpha = 0
    Game.world.timer:tween(0.5, self, {alpha = 1})

    self.box = UIBox(160, 190, 320, 60)
    self.box.layer = -1
    self:addChild(self.box)

    self.title, self.description = statue:getText()
    self.title_text = Text(self.title, 166, 189, 300, 200, {style = "menu"})
    self.title_text.layer = 1
    self:addChild(self.title_text)

    self.description_text = Text(self.description, 166, 225, 300, 200, {style = "menu"})
    self.description_text:setScale(0.5)
    self.description_text.layer = 1
    self:addChild(self.description_text)

    self.open = true
    self.quit = false
end

function Menu:update()
    for _,child in ipairs(self.children) do
        if child == self.box then
            child.alpha = self.alpha * 0.8
        else
            child.alpha = self.alpha
        end
    end
    super:update(self)
    if Input.pressed("cancel") then
        self.open = false
        self.quit = true
        Game.world.timer:tween(0.5, self, {alpha = 0}, "linear", function()
            self:remove()
        end)
    end
end

return Menu