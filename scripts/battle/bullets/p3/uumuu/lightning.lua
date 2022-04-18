local Lightning, super = Class(Bullet)

function Lightning:init(x, y, radius, time, delay)
    super:init(self, x, y)
    self.collider = CircleCollider(self, 0, 0, radius*2/3)
    self.collidable = false
    self.color = {1,1,1}
    self.alpha = 0
    self:setScale(1)

    self.radius = 0
    self.max_radius = radius
    self.time = time
    self.delay = delay or 1
    self.shock = false
end

function Lightning:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        self.wave.timer:tween(0.5, self, {radius = self.max_radius, alpha = 0.1}, "out-cubic")
        wait(self.delay)
        self.color = {0.5, 1, 1}
        self.alpha = 0.3
        self.collidable = true
        self.shock = true
        wait(self.time)
        self.collidable = false
        self.alpha = 0.2
        self.wave.timer:tween(0.3, self, {alpha = 0})
        wait(0.1)
        self.shock = false
        wait(0.2)
        self:remove()
    end)
end

function Lightning:draw()
    super:draw(self)
    local r,g,b = unpack(self.color)
    local a = self.alpha
    love.graphics.setColor(r,g,b,a)
    love.graphics.circle("fill", 0, 0, self.radius)
    if self.shock then
        love.graphics.setColor(1,1,1)
        love.graphics.circle("fill", 0, 0, love.math.random(math.floor(self.radius/8), math.floor(self.radius/4)))
        love.graphics.setLineWidth(1.5)
        local start_angle = Utils.random(math.pi*2/3)
        for i=1,3 do
            local line_angle = start_angle + i*math.pi*2/3 + Utils.random(-0.4,0.4)
            local x, y = 0, 0
            for j=1,love.math.random(3,4) do
                local dir = Utils.randomSign()
                if i ~= 1 then
                    line_angle = line_angle + Utils.random(1.2)*dir
                end
                local prev_x, prev_y = x, y
                for k=1,love.math.random(2) do
                    x, y = prev_x, prev_y
                    local length = love.math.random(math.floor(self.radius/6), math.floor(self.radius/3))
                    x, y = x + length*math.cos(line_angle), y + length*math.sin(line_angle)
                    love.graphics.line(prev_x, prev_y, x, y)
                end
            end
        end
    end
end

return Lightning