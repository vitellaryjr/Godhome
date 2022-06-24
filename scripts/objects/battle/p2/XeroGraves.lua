local Graves, super = Class("UIAttachment")

function Graves:init()
    super:init(self, 64)
    local positions = {
        love.math.random(60),
        160 + love.math.random(-30,30),
        480 + love.math.random(-30,30),
        640 - love.math.random(60),
    }
    for _,x in ipairs(positions) do
        local sprite = Sprite("battle/p2/xero/bg_grave_"..Utils.pick{"a","b","c"}, x, love.math.random(0,2)*2)
        sprite:setOrigin(0.5, 1)
        sprite:setScale(2)
        sprite.alpha = Utils.random(0.5, 0.7)
        self:addChild(sprite)
    end
end

return Graves