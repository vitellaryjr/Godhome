local Chain, super = Class(Object)

function Chain:init(x, y, angle, color)
    super:init(self, x, y)
    self.rotation = angle

    for i=0,math.ceil(SCREEN_WIDTH/32) do
        local sprite = Sprite("battle/common/bg_chain")
        sprite.x = i*32
        sprite:setScale(2)
        sprite.color = color
        sprite.alpha = color[4] or 1
        self:addChild(sprite)
    end
end

local Chains, BG_super = Class(Object)

function Chains:init(colors, amount)
    BG_super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 100
    amount = amount or 8
    for _=1,math.floor(amount/4) do
        local x = math.random(SCREEN_WIDTH/4)
        local angle = Utils.random(math.pi/3, math.pi*2/3)
        self:addChild(Chain(x, -2, angle, colors[2]))
    end
    for _=1,math.floor(amount/4) do
        local x = SCREEN_WIDTH - math.random(SCREEN_WIDTH/4)
        local angle = Utils.random(math.pi/3, math.pi*2/3)
        self:addChild(Chain(x, -2, angle, colors[2]))
    end
    for _=1,math.ceil(amount/4) do
        local x = math.random(SCREEN_WIDTH/4)
        local angle = Utils.random(math.pi/3, math.pi*2/3)
        local chain = Chain(x, -2, angle, colors[1])
        chain.layer = 10
        self:addChild(chain)
    end
    for _=1,math.ceil(amount/4) do
        local x = SCREEN_WIDTH - math.random(SCREEN_WIDTH/4)
        local angle = Utils.random(math.pi/3, math.pi*2/3)
        local chain = Chain(x, -2, angle, colors[1])
        chain.layer = 10
        self:addChild(chain)
    end
end

return Chains