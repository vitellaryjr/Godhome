local BG, super = Class("battle/BaseBG")

function BG:init()
    super:init(self, {0.04, 0.01, 0.04})
    self.color = {0.3, 0.15, 0.3}
    self.back_color = {0.3, 0.05, 0.3}
    self.offset = 0
    self.speed = 1
    self.size = 50
end

function BG:update()
    super:update(self)
    self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*4 then
        self.offset = self.offset - self.size*4
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
    for i = 2, 21 do
        local hx1, hx2 = 0, 640
        if i%2 == 0 then
            local hy1 = -(4*self.size) + (i * self.size) + (self.size/4) + math.floor(self.offset / 2)
            local hy2 = -(4*self.size) + (i * self.size) - (self.size/4) + math.floor(self.offset / 2)
            love.graphics.line(hx1, hy1, hx2, hy2)
        else
            local hy1 = -(4*self.size) + (i * self.size) - (self.size/4) + math.floor(self.offset / 2)
            local hy2 = -(4*self.size) + (i * self.size) + (self.size/4) + math.floor(self.offset / 2)
            love.graphics.line(hx1, hy1, hx2, hy2)
        end

        local vx = -(4*self.size) + (i * self.size) + math.floor(self.offset / 2)
        local vy1, vy2 = 0, 480
        love.graphics.line(vx, vy1, vx, vy2)
    end
end

function BG:drawFront()
    r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
    for i = 3, 20 do
        local hx1, hx2 = 0, 640
        local hy = -(2*self.size) + (i * self.size) - math.floor(self.offset)
        love.graphics.line(hx1, hy, hx2, hy)

        local vy1, vy2 = 0, 480
        if i%2 == 0 then
            local vx1 = -(2*self.size) + (i * self.size) - (self.size/4) - math.floor(self.offset)
            local vx2 = -(2*self.size) + (i * self.size) + (self.size/4) - math.floor(self.offset)
            love.graphics.line(vx1, vy1, vx2, vy2)
        else
            local vx1 = -(2*self.size) + (i * self.size) + (self.size/4) - math.floor(self.offset)
            local vx2 = -(2*self.size) + (i * self.size) - (self.size/4) - math.floor(self.offset)
            love.graphics.line(vx1, vy1, vx2, vy2)
        end
    end
end

return BG