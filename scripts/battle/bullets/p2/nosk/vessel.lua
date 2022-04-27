local Vessel, super = Class(Bullet)

Vessel.positions = {
    a = {8,18},
    b = {8,5},
    c = {8,8},
}

function Vessel:init(x, y)
    self.type = Utils.pick{"a","b","c"}
    super:init(self, x, y, "battle/p2/nosk/vessel_"..self.type)
    self:setHitbox(6,9,4,8)

    self.sprite:setRotationOrigin(0.5, 0.5)

    self.lines = {}
    for _=1,3 do
        local line = {
            self.width/2 + love.math.random(-2, 2), self.height/2,
            self.width/2 + love.math.random(-2, 2), -150,
        }
        table.insert(self.lines, line)
    end

    self.timer = Timer()
    self:addChild(self.timer)
    self.timer:after(Utils.random(0.3, 0.7), function()
        self.timer:everyInstant(Utils.random(1, 1.5), function()
            self:fire()
        end)
    end)

    self.shaking = false
end

function Vessel:update()
    super:update(self)
    if self.shaking then
        self.sprite.rotation = Utils.random(-0.1,0.1)
    else
        self.sprite.rotation = 0
    end
end

function Vessel:draw()
    love.graphics.setColor(1,1,1, 0.5)
    love.graphics.setLineWidth(0.5)
    for _,line in ipairs(self.lines) do
        love.graphics.line(line)
    end
    love.graphics.setLineWidth(1)
    super:draw(self)
end

function Vessel:fire()
    local x, y = self.x + self.positions[self.type][1] - self.width/2, self.y + self.positions[self.type][2] - self.height/2
    Game.battle:addChild(ParticleEmitter(x, y, {
        layer = BATTLE_LAYERS["below_bullets"],
        shape = "circle",
        color = {1, 0.2, 0},
        alpha = 0.5,
        scale = 0.8,
        scale_var = 0.2,
        angle = {0,math.pi*2},
        speed = 4,
        speed_var = 1,
        friction = 0.1,
        shrink = 0.1,
        shrink_after = 0.1,
        every = 0.1,
        amount = {1,2},
        time = 0.5,
    }))
    self.shaking = true
    self.timer:after(0.5, function()
        self.shaking = false
        local soul = Game.battle.soul
        local bullet = self.wave:spawnBullet("common/infection", x, y)
        bullet.physics = {
            speed = 6,
            direction = Utils.angle(x, y, soul.x, soul.y),
            gravity = 0.05,
            gravity_direction = math.pi/2,
        }
        bullet.layer = self.layer - 1
    end)
end

return Vessel