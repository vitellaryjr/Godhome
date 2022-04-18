local Fade, super = Class(Object)

function Fade:init(color, from, to, time, after)
    super:init(self)
    self.layer = BATTLE_LAYERS["top"]
    self.alpha = from

    self.color = color
    self.to = to
    self.time = time
    self.after = after

    self.started = false
end

function Fade:onAdd(parent)
    super:onAdd(self, parent)
    if self.started then return end
    self.started = true
    if self.time then
        parent.timer:tween(self.time, self, {alpha = self.to}, "linear", function()
            if self.after then self:after() end
        end)
    end
end

function Fade:draw()
    super:draw(self)
    local r,g,b = unpack(self.color)
    love.graphics.setColor(r,g,b, self.alpha)
    if self.parent == Game.world then
        love.graphics.rectangle("fill", Game.world.camera.x - SCREEN_WIDTH, Game.world.camera.y - SCREEN_HEIGHT, SCREEN_WIDTH*2, SCREEN_HEIGHT*2)
    else
        love.graphics.rectangle("fill", 0,0, SCREEN_WIDTH,SCREEN_HEIGHT)
    end
end

return Fade