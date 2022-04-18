local BG, super = Class("battle/BaseBG")

function BG:init()
    super:init(self, {0.04, 0.025, 0.01})
    self.color = {0.3, 0.22, 0.1}
    self.back_color = {0.3, 0.15, 0.05}
    self.offset = 0
    self.speed = 1
    self.size = 50
end

function BG:update(dt)
    super:update(self, dt)
    self.offset = self.offset + self.speed*DTMULT

    if self.offset > self.size*3 then
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
    for i=-4,16 do
        local s = self.size
        local cx = i*s - math.floor(self.offset/2)
        for j=-4,16 do
            local x = cx
            if j%2 == 0 then
                x = x - s/2
            end
            local y = j*s - math.floor(self.offset/2) + math.floor(s/3)
            local shape = {
                x,     y,
                x+s/2, y+s/2,
                x+s/2, y+s,
                x,     y+s*3/2,
                x-s/2, y+s,
                x-s/2, y+s/2,
            }
            love.graphics.polygon("line", shape)
        end
    end
end

function BG:drawFront()
    r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
    for i=-4,16 do
        local s = self.size
        local cx = i*s + math.floor(self.offset)
        for j=-4,16 do
            local x = cx
            if j%2 == 0 then
                x = x - s/2
            end
            local y = j*s + math.floor(self.offset)
            local shape = {
                x,     y,
                x+s/2, y+s/2,
                x+s/2, y+s,
                x,     y+s*3/2,
                x-s/2, y+s,
                x-s/2, y+s/2,
            }
            love.graphics.polygon("line", shape)
        end
    end
end

return BG