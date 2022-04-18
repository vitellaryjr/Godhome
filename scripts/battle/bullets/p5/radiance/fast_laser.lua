local Laser, super = Class(Bullet)

function Laser:init(x, y, angle)
    super:init(self, x, y)
    self:setHitbox(0, -6, 2000, 12)
    self:setScale(1)

    self.rotation = angle
    self.remove_offscreen = false

    self.state = "charging"
    self.laser_timer = 0
    self.laser_width = 0
    self.circle_rad = 0

    self.only_circle = false

    self.added = false
end

function Laser:onAdd(parent)
    super:onAdd(self, parent)
    if self.added then return end
    self.added = true
    if self.state ~= "firing" then
        self.collidable = false
        if self.state == "charging" then
            Assets.playSound("bosses/radiance/laser_prepare", 0.3)
            self.wave.timer:after(0.4, function()
                self:fire()
            end)
        end
    else
        self:fire()
    end
end

function Laser:update(dt)
    super:update(self, dt)
    self.laser_timer = self.laser_timer + dt
    if self.state == "charging" then
        self.laser_width = 2 + math.abs(math.sin(self.laser_timer*15)*2)
        self.circle_rad = 10 + math.sin(self.laser_timer*15)
    elseif self.state == "firing" then
        self.laser_width = 16 + math.sin(self.laser_timer*30)*2
        self.circle_rad = 18 + math.sin(self.laser_timer*30)*2
    elseif self.state == "fadeout" then
        self.circle_rad = self.laser_width
    end
end

function Laser:draw()
    local canvas = Draw.pushCanvas(2000, 2000)
        love.graphics.translate(24, 80)
        if self.state == "charging" then
            love.graphics.setColor({0.5, 0.5, 0.3})
            love.graphics.circle("fill", 0, 0, 16)
            if not self.only_circle then
                love.graphics.rectangle("fill", 0, -self.laser_width/2, 2000, self.laser_width)
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", 0, 0, self.circle_rad)
        elseif self.state == "firing" then
            love.graphics.setColor({0.5, 0.5, 0.3})
            love.graphics.circle("fill", 0, 0, 24)
            love.graphics.rectangle("fill", 0, -12, 2000, 24)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 0, -self.laser_width/2, 2000, self.laser_width)
            love.graphics.circle("fill", 0, 0, self.circle_rad)
        elseif self.state == "fadeout" then
            love.graphics.setColor({0.5, 0.5, 0.3})
            love.graphics.circle("fill", 0, 0, self.circle_rad)
            if not self.only_circle then
                love.graphics.rectangle("fill", 0, -self.laser_width/2, 2000, self.laser_width)
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", 0, 0, self.circle_rad*0.75)
        end
    Draw.popCanvas()

    love.graphics.push()
    love.graphics.translate(-24,-80)
    love.graphics.setBlendMode("add")
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.pop()

    super:draw(self)
end

function Laser:fire()
    self.state = "firing"
    self.collidable = true
    Assets.playSound("bosses/radiance/laser_burst", 0.3)
    self.wave.timer:after(0.2, function()
        self.state = "fadeout"
        self.collidable = false
        self.wave.timer:tween(0.5, self, {laser_width = 0}, "out-expo", function()
            self:remove()
        end)
    end)
end

-- change the laser's parent to Game.battle
function Laser:release(x, y)
    self:setPosition(x, y)
    self:setParent(Game.battle)
    self:setLayer(BATTLE_LAYERS["bullets"])
    self:setScale(1, 1)
end

return Laser