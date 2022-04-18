local Candles, super = Class("battle/UIAttachment")

function Candles:init(darkness)
    super:init(self, 40)
    local positions = {
        love.math.random(60),
        160 + love.math.random(-30,30),
        480 + love.math.random(-30,30),
        640 - love.math.random(60),
    }
    for _,x in ipairs(positions) do
        local sprite = Sprite("battle/p3/sly/candle", x, love.math.random(8))
        sprite.frame = love.math.random(2)+1
        sprite:play(0.2, true)
        sprite:setOrigin(0.5, 1)
        sprite:setScale(2)
        sprite.alpha = Utils.random(0.5, 0.7)
        self:addChild(sprite)
        table.insert(darkness.lights, {x = x, y = function() return self.y - sprite.y*2 - 40 end, radius = 60})
    end
end

return Candles