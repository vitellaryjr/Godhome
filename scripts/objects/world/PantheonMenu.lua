local Menu, super = Class(Object)

function Menu:init(pantheon_num)
    super:init(self, 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0
    self.alpha = 0
    Game.world.timer:tween(0.5, self, {alpha = 1})

    self.box = UIBox(220, 80, 200, 300)
    self.box.layer = -1
    self:addChild(self.box)

    self.pantheon_num = pantheon_num

    if pantheon_num == 5 then
        self.pre_title = "PANTHEON OF"
    else
        self.pre_title = "PANTHEON OF THE"
    end
    self.pre_title_text = Text("[style:menu]"..self.pre_title, 320, 70)
    local pre_title_text_obj = love.graphics.newText(self.pre_title_text:getFont(), self.pre_title)
    self.pre_title_text:setScale(0.5)
    self.pre_title_text.x = 320 - Utils.round(pre_title_text_obj:getWidth()/4)
    self.pre_title_text.layer = 1
    self:addChild(self.pre_title_text)

    if pantheon_num == 1 then
        self.title = "MASTER"
    elseif pantheon_num == 2 then
        self.title = "ARTIST"
    elseif pantheon_num == 3 then
        self.title = "SAGE"
    elseif pantheon_num == 4 then
        self.title = "KNIGHT"
    elseif pantheon_num == 5 then
        self.title = "HALLOWNEST"
    end
    self.title_text = Text("[style:menu]"..self.title, 320, 84)
    local title_text_obj = love.graphics.newText(self.title_text:getFont(), self.title)
    self.title_text.x = 320 - Utils.round(title_text_obj:getWidth()/2)
    self.title_text.layer = 1
    self:addChild(self.title_text)

    if pantheon_num == 1 then
        self.description = "Seek the gods of Nail and Shell"
    elseif pantheon_num == 2 then
        self.description = "Seek the God Inspired"
    elseif pantheon_num == 3 then
        self.description = "Seek the God of Wealth and Power"
    elseif pantheon_num == 4 then
        self.description = "Seek the Pure God"
    elseif pantheon_num == 5 then
        self.description = "Seek the Kingdom's Forgotten Light"
    end
    self.description_text = Text("[style:menu]"..self.description, 320, 120)
    local description_text_obj = love.graphics.newText(self.description_text:getFont(), self.description)
    self.description_text:setScale(0.5)
    self.description_text.x = 320 - Utils.round(description_text_obj:getWidth()/4)
    self.description_text.layer = 1
    self:addChild(self.description_text)

    self.binding_text = Text("[style:menu]BINDINGS", 320, 140)
    local binding_text_obj = love.graphics.newText(self.binding_text:getFont(), "BINDINGS")
    self.binding_text.x = 320 - Utils.round(binding_text_obj:getWidth()/2)
    self.binding_text.layer = 1
    self:addChild(self.binding_text)

    self.buttons = {}

    local bindings = {"nail", "hp", "tp", "magic"}
    self.binding_buttons = {}
    for i,name in ipairs(bindings) do
        local button = BindingButton(235, 140 + i*40, name)
        button.layer = 1
        self:addChild(button)
        table.insert(self.binding_buttons, button)
        table.insert(self.buttons, button)
    end
    self.binding_buttons[1]:toggleHover(true)

    self.enter_button = PantheonEnterButton(320, 350, (pantheon_num == 5 and "ASCEND" or "BEGIN"))
    self.enter_button.layer = 1
    self:addChild(self.enter_button)
    table.insert(self.buttons, self.enter_button)

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
        if self.hover_index <= 4 then
            self.binding_buttons[self.hover_index].enabled = not self.binding_buttons[self.hover_index].enabled
            local all_active = true
            local active_count = 0
            for _,button in ipairs(self.binding_buttons) do
                if not button.enabled then
                    all_active = false
                else
                    active_count = active_count + 1
                end
            end
            Assets.playSound("pantheon/binding_chain", 1, 1 + active_count*0.07)
            local cx, cy = Game.world.camera.x, Game.world.camera.y
            local intensity = 2
            if all_active then intensity = 6 end
            Game.world.timer:during(0.2, function()
                Game.world.camera.x = cx + love.math.random(-intensity, intensity)
                Game.world.camera.y = cy + love.math.random(-intensity, intensity)
            end, function()
                Game.world.camera.x = cx
                Game.world.camera.y = cy
            end)
            if all_active then
                Assets.playSound("pantheon/binding_glow")
                Game.world:spawnObject(ScreenFade({1,0.95,0.7}, 0.2,0, 0.5), "above_ui")
            end
            for _,button in ipairs(self.binding_buttons) do
                if all_active then
                    button:toggleActive("glow")
                else
                    if button.enabled then
                        button:toggleActive("active")
                    else
                        button:toggleActive("inactive")
                    end
                end
            end
        else
            self.open = false
            self.quit = false
            Game.world.timer:tween(0.5, self, {alpha = 0}, "linear", function()
                self:remove()
            end)
        end
    elseif Input.pressed("up") and self.hover_index > 1 then
        local prev_index = self.hover_index
        self.hover_index = self.hover_index - 1
        self.buttons[prev_index]:toggleHover(false)
        self.buttons[self.hover_index]:toggleHover(true)
    elseif Input.pressed("down") and self.hover_index < 5 then
        local prev_index = self.hover_index
        self.hover_index = self.hover_index + 1
        self.buttons[prev_index]:toggleHover(false)
        self.buttons[self.hover_index]:toggleHover(true)
    end
end

return Menu