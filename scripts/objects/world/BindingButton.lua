local Button, super = Class(Object)

function Button:init(x, y, name)
    super:init(self, x, y)
    self.name = name

    self.icon = Sprite("tilesets/doors/binding_"..name.."_inactive", 20, 0)
    self.icon:setScale(2)
    self:addChild(self.icon)

    if name == "nail" then
        self.title = "Nail"
    elseif name == "hp" then
        self.title = "Health"
    elseif name == "tp" then
        self.title = "Tension"
    elseif name == "magic" then
        self.title = "Magic"
    end
    self.title_text = Text("[style:menu]"..self.title, 60, 0)
    self:addChild(self.title_text)

    self.soul = Sprite("player/heart_menu", -2, 8)
    self.soul:setScale(2)
    self.soul.visible = false
    self:addChild(self.soul)

    self.chain_1 = Sprite("tilesets/doors/chain", 20, 4)
    self.chain_1.layer = -1
    self.chain_1:setOrigin(0, 0.5)
    self.chain_1:setScale(1, 0)
    self.chain_1.rotation = Utils.random(math.rad(9), math.rad(11))
    self:addChild(self.chain_1)
    self.chain_2 = Sprite("tilesets/doors/chain", 20, 30)
    self.chain_2.layer = -1
    self.chain_2:setOrigin(0, 0.5)
    self.chain_2:setScale(1, 0)
    self.chain_2.rotation = Utils.random(math.rad(-9), math.rad(-11))
    self:addChild(self.chain_2)

    self.enabled = false
    self.state = "inactive"
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

function Button:toggleActive(state)
    local prev_state = self.state
    self.state = state
    self.icon:setTexture("tilesets/doors/binding_"..self.name.."_"..state)
    if state == "active" then
        self.chain_1.color = {120/255, 73/255, 78/255}
        self.chain_2.color = {120/255, 73/255, 78/255}
    elseif state == "glow" then
        self.chain_1.color = {212/255, 166/255, 141/255}
        self.chain_2.color = {212/255, 166/255, 141/255}
    end
    if prev_state == "inactive" and state ~= "inactive" then
        Game.world.timer:tween(0.1, self.chain_1, {scale_y = 1}, "linear", function()
            self.chain_1:setScale(1, 1)
        end)
        Game.world.timer:tween(0.1, self.chain_2, {scale_y = 1}, "linear", function()
            self.chain_2:setScale(1, 1)
        end)
    elseif state == "inactive" and prev_state ~= "inactive" then
        Game.world.timer:tween(0.1, self.chain_1, {scale_y = 0}, "linear", function()
            self.chain_1:setScale(1, 0)
        end)
        Game.world.timer:tween(0.1, self.chain_2, {scale_y = 0}, "linear", function()
            self.chain_2:setScale(1, 0)
        end)
    end
end

return Button