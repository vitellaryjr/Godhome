local Carousel, C_super = Class(Object)

Carousel.COLORS = {
    {0.22, 0.1, 0.5},
    {0.3, 0.25, 0.63},
}

function Carousel:init()
    C_super:init(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
    self.layer = BATTLE_LAYERS["bottom"] + 10

    self.points = {}
    for i=1,8 do
        table.insert(self.points, {
            angle = i*math.pi/4,
            color = self.COLORS[i%2+1],
            fg = false,
        })
    end
end

function Carousel:update()
    C_super:update(self)

    for _,point in ipairs(self.points) do
        point.angle = (point.angle-0.03*DTMULT)%(2*math.pi)
    end
end

function Carousel:draw()
    C_super:draw(self)

    for i,point in ipairs(self.points) do
        local x, y = math.cos(point.angle)*360, math.sin(point.angle)*120
        local np = self.points[i%8+1]
        local nx, ny = math.cos(np.angle)*360, math.sin(np.angle)*120

        love.graphics.setColor(point.color)
        love.graphics.polygon("fill", 
            0, 0,
            x, y,
            nx, ny
        )
        point.fg = nx < x
    end
    
    for i,point in ipairs(self.points) do
        if not point.fg then
            local x, y = math.cos(point.angle)*60, math.sin(point.angle)*20
            local np = self.points[i%8+1]
            local nx, ny = math.cos(np.angle)*60, math.sin(np.angle)*20

            if Utils.sign(y) ~= Utils.sign(ny) then
                love.graphics.setColor(point.color)
                love.graphics.polygon("fill", 
                    0, -80,
                    x, y,
                    nx, ny
                )
            end
        end
    end
    for i,point in ipairs(self.points) do
        if point.fg then
            local x, y = math.cos(point.angle)*60, math.sin(point.angle)*20
            local np = self.points[i%8+1]
            local nx, ny = math.cos(np.angle)*60, math.sin(np.angle)*20

            love.graphics.setColor(point.color)
            love.graphics.polygon("fill", 
                0, -80,
                x, y,
                nx, ny
            )
        end
    end

    for i,point in ipairs(self.points) do
        if not point.fg then
            local x, y = math.cos(point.angle)*60, math.sin(point.angle)*20-270
            local np = self.points[i%8+1]
            local nx, ny = math.cos(np.angle)*60, math.sin(np.angle)*20-270

            if Utils.sign(y) ~= Utils.sign(ny) then
                love.graphics.setColor(point.color)
                love.graphics.polygon("fill", 
                    0, -80,
                    x, y,
                    nx, ny
                )
            end
        end
    end
    for i,point in ipairs(self.points) do
        if point.fg then
            local x, y = math.cos(point.angle)*60, math.sin(point.angle)*20-270
            local np = self.points[i%8+1]
            local nx, ny = math.cos(np.angle)*60, math.sin(np.angle)*20-270

            love.graphics.setColor(point.color)
            love.graphics.polygon("fill", 
                0, -80,
                x, y,
                nx, ny
            )
        end
    end

    for i,point in ipairs(self.points) do
        local x, y = math.cos(point.angle)*360, math.sin(point.angle)*100-270
        local np = self.points[i%8+1]
        local nx, ny = math.cos(np.angle)*360, math.sin(np.angle)*100-270

        love.graphics.setColor(np.color)
        love.graphics.polygon("fill", 
            0, -270,
            x, y,
            nx, ny
        )
    end
end

return Carousel