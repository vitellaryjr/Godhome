local Laser, super = Class(Bullet)

function Laser:init(x, y, offset, time, state)
    super:init(self, x, y)

    self:setScale(0.5, 0.5)
    self:setHitbox(0, -6, 1000, 12)
    self.layer = -100

    self.offset = offset or 16
    self.time = time or -1
    self.state = state or "charging"

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
            self.wave.timer:after(0.6, function()
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
    local additive = self.parent.parent ~= Game.battle.mask
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
        love.graphics.translate(24 + self.offset, 80)
        if self.state == "charging" then
            love.graphics.setColor(additive and {0.5, 0.5, 0.5} or {1,1,1, 0.8})
            love.graphics.circle("fill", 0, 0, 16)
            if not self.only_circle then
                love.graphics.rectangle("fill", 0, -self.laser_width/2, 1000, self.laser_width)
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", 0, 0, self.circle_rad)
        elseif self.state == "firing" then
            love.graphics.setColor(additive and {0.5, 0.5, 0.5} or {1,1,1, 0.8})
            love.graphics.circle("fill", 0, 0, 24)
            love.graphics.rectangle("fill", 0, -12, 1000, 24)
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("fill", 0, -self.laser_width/2, 1000, self.laser_width)
            love.graphics.circle("fill", 0, 0, self.circle_rad)
        elseif self.state == "fadeout" then
            love.graphics.setColor(additive and {0.5, 0.5, 0.5} or {1,1,1, 0.8})
            love.graphics.circle("fill", 0, 0, self.circle_rad)
            if not self.only_circle then
                love.graphics.rectangle("fill", 0, -self.laser_width/2, 1000, self.laser_width)
            end
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle("fill", 0, 0, self.circle_rad*0.75)
        end
    Draw.popCanvas()

    love.graphics.push()
    love.graphics.translate(-24,-80)
    if additive then
        love.graphics.setBlendMode("add")
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
    love.graphics.pop()

    super:draw(self)
end

function Laser:fire()
    self.state = "firing"
    self.collidable = true
    if self.time > 0 then
        self.wave.timer:after(self.time, function()
            self.state = "fadeout"
            self.collidable = false
            self.wave.timer:tween(0.8, self, {laser_width = 0}, "out-expo", function()
                self:remove()
            end)
        end)
    end
end

-- change the laser's parent to Game.battle
function Laser:release(x, y)
    self:setPosition(x, y)
    self:setParent(Game.battle)
    self:setLayer(BATTLE_LAYERS["bullets"])
    self:setScale(1, 1)
end

return Laser