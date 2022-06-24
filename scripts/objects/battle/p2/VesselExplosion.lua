local Explosion, super = Class(Object)

function Explosion:init(x, y)
    super:init(self, x, y)
    self.layer = BATTLE_LAYERS["below_soul"]
    self.radius = 32
    self.alpha = 0
    self.graphics.fade_to = 0.5
    self.graphics.fade = 0.07
    self.color = {1, 0.4, 0}
end

function Explosion:onAdd(parent)
    self.ps = ParticleEmitter(self.x, self.y, {
        layer = BATTLE_LAYERS["below_soul"] + 10,
        shape = "circle",
        color = Utils.copy(self.color),
        alpha = 0.5,
        scale = 0.8,
        scale_var = 0.2,
        angle = {0,math.pi*2},
        speed = 2,
        speed_var = 0.5,
        friction = 0.1,
        shrink = 0.1,
        shrink_after = 0.1,
        every = 0.2,
        amount = {2,4},
    })
    self.wave:addChild(self.ps)
end

function Explosion:onRemove(parent)
    super:onRemove(self, parent)
    Game.battle.timer:after(0.01, function()
        self.ps:remove()
    end)
end

function Explosion:setColor(r, g, b, a)
    super:setColor(self, r,g,b,a)
    self.ps.data.color = {r,g,b}
end

function Explosion:draw()
    local r,g,b = unpack(self.color)
    love.graphics.setColor(r,g,b, self.alpha)
    love.graphics.circle("fill", 0,0, self.radius)
    super:draw(self)
end

function Explosion:add()
    self.radius = self.radius + 8
    self.alpha = 0.7
end

function Explosion:explode()
    self.graphics.fade_to = 0.8
    self.graphics.fade = 0.1
    self.graphics.fade_callback = function()
        self.wave:spawnBullet("common/explosion", self.x, self.y, self.radius - 8)
        self:remove()
    end
end

return Explosion