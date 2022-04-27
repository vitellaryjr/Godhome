local BG, super = Class("battle/BaseBG")

function BG:init(color, back_color, fill)
    super:init(self, fill)
    self.color = color
    self.back_color = back_color or color
    self.offset = 0
    self.speed = 1
    self.size = 50
end

function BG:update()
    super:update(self)
    self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*2 then
        self.offset = self.offset - self.size*2
    end
end

function BG:draw()
    super:draw(self)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(1)

    self:drawBack()
    self:drawFront()
end

function BG:drawBack()
    local r,g,b,a = unpack(self.back_color)
    love.graphics.setColor(r,g,b, a or self.fade/2)
    for i = 2, 16 do
        local hx1, hx2 = 0, 640
        local hy = -(4*self.size) + (i * self.size) + math.floor(self.offset / 2)
        love.graphics.line(hx1, hy, hx2, hy)

        local vx = -(4*self.size) + (i * self.size) + math.floor(self.offset / 2)
        local vy1, vy2 = 0, 480
        love.graphics.line(vx, vy1, vx, vy2)
    end
end

function BG:drawFront()
    r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
    for i = 3, 16 do
        local hx1, hx2 = 0, 640
        local hy = -(2*self.size) + (i * self.size) - math.floor(self.offset)
        love.graphics.line(hx1, hy, hx2, hy)

        local vx = -(2*self.size) + (i * self.size) - math.floor(self.offset)
        local vy1, vy2 = 0, 480
        love.graphics.line(vx, vy1, vx, vy2)
    end
end

return BG