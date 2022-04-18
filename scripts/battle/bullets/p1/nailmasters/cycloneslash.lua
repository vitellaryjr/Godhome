local Cyclone, super = Class(Bullet)

function Cyclone:init(x, y, dir)
    super:init(self, x, y, "battle/p1/nailmasters/glow")
    self:setOrigin(0,0.5)
    self:setHitbox(4,6,12,48)
    self.collidable = false
    self.rotation = dir

    self.sprite.alpha = 0
    self.sprite.graphics = {
        fade_to = 1,
        fade = 0.08,
    }
    self.ps = ParticleEmitter(0, 0, 0, 40, {
        shape = "circle",
        angle = 0,
        size = 4,
        physics = {
            speed = 2,
            friction = 0.1,
            friction_var = 0.05,
        },
        fade = 0.1,
        fade_var = 0.02,
        amount = {1,2},
        every = 0.1,
        parent = true,
    })
    self:addChild(self.ps)
    self.timer = Timer()
    self:addChild(self.timer)

    self.phase = 1
end

function Cyclone:onAdd(parent)
    super:onAdd(self, parent)
    if self.phase ~= 1 then return end
    self.timer:script(function(wait)
        wait(1.2)
        self.phase = 2
        Game.battle:addChild(ScreenFade({1,1,1}, 0.2, 0, 0.1))
        self.ps:remove()
        Game.battle.shake = 4
        self:setParent(Game.battle)
        self:setSprite("battle/p1/nailmasters/cycloneslash", 0.1, true)
        self:setOrigin(0.5, 0.5)
        self.collidable = true
        local arena = Game.battle.arena
        local soul = Game.battle.soul
        local dir = self.rotation
        if dir % math.pi == 0 then -- horizontal
            self.timer:tween(1, self, {y = soul.y}, "out-sine")
            self.physics.speed_x = 0
            self.timer:tween(1.2, self.physics, {speed_x = 12*math.cos(dir)}, "in-sine")
        else
            self.timer:tween(1, self, {x = soul.x}, "out-sine")
            self.physics.speed_y = 0
            self.timer:tween(1.2, self.physics, {speed_y = 12*math.sin(dir)}, "in-sine")
        end
    end)
end

function Cyclone:draw()
    if self.phase == 1 then
        love.graphics.setColor(1,1,1, self.sprite.alpha/10)
        love.graphics.circle("fill", 0,self.height/2, 30)
    end
    super:draw(self)
end

return Cyclone