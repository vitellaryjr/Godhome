local Spike, super = Class(Bullet)

function Spike:init(x, y, dir)
    super:init(self, x, y, "battle/p3/godtamer/spikes")
    self:setHitbox(0,0,15,20)
    self.rotation = dir
    self.tp = 0

    local comp = NailComponent()
    function comp.knockbackAngle(obj, source)
        return self.rotation
    end
    self:addChild(comp)
end

function Spike:activate()
    local sx, sy = self.x, self.y
    local dx, dy = math.cos(self.rotation), math.sin(self.rotation)
    self.wave.timer:tween(0.1, self, {x = sx + 5*dx, y = sy + 5*dy}, "out-quad")
    self.wave.timer:during(0.6, function(dt)
        self.sprite:setPosition(love.math.random(-1,1), love.math.random(-1,1))
    end, function()
        self.sprite:setPosition(0,0)
        self.wave.timer:tween(0.1, self, {x = sx + 30*dx, y = sy + 30*dy}, "linear")
    end)
end

function Spike:deactivate()
    local sx, sy = self.x, self.y
    local dx, dy = -math.cos(self.rotation), -math.sin(self.rotation)
    self.wave.timer:tween(0.1, self, {x = sx + 40*dx, y = sy + 40*dy}, "linear")
end

return Spike