local Nails, super = Class("battle/UIAttachment")

function Nails:init()
    super:init(self, 100)
    self.tris = {}
    for i=0,5 do
        local tri = {
            x = 50 + i*108,
            h = love.math.random(50,80),
            angle = Utils.random(math.pi*7/8, math.pi*9/8),
            alpha = Utils.random(0.2,0.5),
        }
        table.insert(self.tris, tri)
    end
end

function Nails:draw()
    super:draw(self)
    for _,tri in ipairs(self.tris) do
        self:drawNail(tri.x, 10, 30, tri.h, tri.angle, tri.alpha)
    end
end

function Nails:drawNail(x, y, width, height, angle, alpha)
	love.graphics.push()
    love.graphics.setColor(1.6*alpha,1.6*alpha,1.8*alpha, alpha)
	love.graphics.translate(x, y)
	love.graphics.rotate(angle)
    local handle_len = math.floor(height/4)
	love.graphics.polygon("fill", {
        0,0,
        width/2,height,
        2,height,
        2,height+handle_len,
        -2,height+handle_len,
        -2,height,
        -width/2,height,
    })
	love.graphics.pop() 
end

return Nails