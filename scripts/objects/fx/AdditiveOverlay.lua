local Overlay, super = Class(Object)

function Overlay:init(color, texture)
    super:init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.layer = BATTLE_LAYERS["top"] + 100
    self.color = color
    self.alpha = color[4] or 1
    if texture then
        local ref_sprite = Sprite(texture, 0, 0)
        for x=0,math.ceil(SCREEN_WIDTH/ref_sprite.width) + 1 do
            for y=0,math.ceil(SCREEN_HEIGHT/ref_sprite.height) + 1 do
                local sprite = Sprite(texture, x*ref_sprite.width, y*ref_sprite.height)
                sprite.inherit_color = true
                self:addChild(sprite)
                if x == 0 and y == 0 then
                    self.sprite = sprite
                end
            end
        end
        self.width = math.ceil(SCREEN_WIDTH/ref_sprite.width)
        self.height = math.ceil(SCREEN_HEIGHT/ref_sprite.height)
    end
end

function Overlay:draw()
    local prev = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add")
    super:draw(self)
    if not self.sprite then
        local pr,pg,pb,pa = love.graphics.getColor()
        local r,g,b,a = unpack(self.color)
        if not a then a = self.alpha end
        love.graphics.setColor(r,g,b,a)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        love.graphics.setColor(r,g,b,a)
    end
    love.graphics.setBlendMode(prev)
end

return Overlay