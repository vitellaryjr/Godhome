local Color, super = Class("movement")

function Color:init(x, y, type)
    super:init(self, x, y, type)
    local arena = Game.battle.arena
    local w,h = arena.width, arena.height
    self:setHitbox(-w/4, -h/4, w/2, h/2)
    self.collidable = false
    self.alpha = 0
    self.graphics = {
        fade_to = 0.1,
        fade = 0.005,
    }
end

function Color:draw()
    local r,g,b = unpack(self.color)
    love.graphics.setColor(r,g,b, self.alpha)
    local w,h = self.collider.width, self.collider.height
    love.graphics.rectangle("fill", -w/2, -h/2, w, h)
    super:draw(self)
end

function Color:slash()
    self.collidable = true
    self.alpha = 0.5
    self:fadeOutAndRemove(0.05)
    self.wave.timer:after(0.1, function()
        self.collidable = false
    end)
end

return Color