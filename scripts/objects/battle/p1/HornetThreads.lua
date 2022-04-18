local Threads, super = Class(Object)

function Threads:init()
    super:init(self, 0,0,640,480)
    self.layer = BATTLE_LAYERS["bottom"]+10
    self.color = {0.7, 0.7, 0.72, 0.7}
    
    self.lines = {}
    for _=1,4 do
        self:spawn(0,love.math.random(40,480), love.math.random(40,120),0)
        self:spawn(640,love.math.random(40,480), 640-love.math.random(40,120),0)
    end
end

function Threads:draw()
    super:draw(self)
    love.graphics.setColor(self.color)
    for _,line in ipairs(self.lines) do
        love.graphics.line(line:render())
    end
end

function Threads:spawn(x1, y1, x2, y2)
    local curve = love.math.newBezierCurve(x1,y1, (x1+x2)/2,(y1+y2)/2 + love.math.random(20,100), x2,y2)
    table.insert(self.lines, curve)
end

return Threads