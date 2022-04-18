local Flowers, super = Class("battle/UIAttachment")

function Flowers:init()
    super:init(self, 64)
    self.layer = BATTLE_LAYERS["above_ui"]
    local positions = {
        60,
        160,
        480,
        600,
    }
    for _,x in ipairs(positions) do
        for __=1,love.math.random(3) do
            local sprite = Sprite("battle/p4/traitorlord/bg_flower", x + love.math.random(-40,40), love.math.random(-6,6))
            sprite:setOrigin(0.5, 0.5)
            sprite:setScale(Utils.random(1.5,2))
            sprite.rotation = Utils.random(math.pi*2)
            sprite.alpha = 0.8
            self:addChild(sprite)
        end
    end
end

return Flowers