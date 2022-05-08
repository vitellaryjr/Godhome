local Menu, super = Class(Object)

function Menu:init(statue)
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.alpha = 0
    Game.world.timer:tween(0.5, self, {alpha = 1})

    self.box = UIBox(160, 100, 320, 200)
    self.box.layer = -1
    self:addChild(self.box)

    self.title, self.description = statue:getText()
    self.title_text = Text(self.title, 166, 94, 300, 200, {style = "menu"})
    self.title_text.layer = 1
    self:addChild(self.title_text)

    self.description_text = Text(self.description, 166, 130, 300, 200, {style = "menu"})
    self.description_text:setScale(0.5)
    self.description_text.layer = 1
    self:addChild(self.description_text)

    local difficulties = {"attuned", "ascended", "radiant"}
    self.buttons = {}
    for i,name in ipairs(difficulties) do
        local button = {x = 166, y = 130 + i*40, type = name}

        button.sprite = Sprite("tilesets/statues/difficulty_"..button.type, button.x + 24, button.y)
        if name == "ascended" then button.sprite.y = button.y - 2 end
        button.sprite:setScale(2)
        self:addChild(button.sprite)

        button.name = Utils.titleCase(button.type)
        button.text = Text(button.name, button.x + 64, button.y, 200, 200, {style = "menu"})
        button.text.layer = 1
        self:addChild(button.text)

        button.soul = Sprite("player/heart_menu", button.x - 2, button.y + 8)
        button.soul:setScale(2)
        button.soul.visible = i == 1
        self:addChild(button.soul)

        table.insert(self.buttons, button)
    end

    self.open = true
    self.quit = false
    self.hover_index = 1
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
    elseif Input.pressed("confirm") then
        self.open = false
        self.quit = false
        self.difficulty = self.buttons[self.hover_index].type
        Game.world.timer:tween(0.5, self, {alpha = 0}, "linear", function()
            self:remove()
        end)
    elseif Input.pressed("up") and self.hover_index > 1 then
        self.buttons[self.hover_index].soul.visible = false
        self.hover_index = self.hover_index - 1
        self.buttons[self.hover_index].soul.visible = true
    elseif Input.pressed("down") and self.hover_index < 3 then
        self.buttons[self.hover_index].soul.visible = false
        self.hover_index = self.hover_index + 1
        self.buttons[self.hover_index].soul.visible = true
    end
end

return Menu