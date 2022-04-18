local Dash, super = Class(Bullet)

function Dash:init(x, y, dir, slow)
    super:init(self, x, y, "battle/p1/nailmasters/glow")
    self:setOrigin(0, 0.5)
    self:setHitbox(0,1,80,38)
    self.collidable = false
    self.rotation = dir
    self.tp = 3.2
    self.double_damage = true

    self.sprite.alpha = 0
    self.sprite.graphics = {
        fade_to = 1,
        fade = 0.16,
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

    self.phase = 1
    self.slow = slow
end

function Dash:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        wait(0.8)
        Game.battle:addChild(ScreenFade({1,1,1}, 0.2, 0, 0.1))
        self.ps:remove()
        Game.battle.shake = 4
        self:setSprite("battle/p1/nailmasters/dashslash", 0.1, true)
        self.collidable = true
        self.phase = 2
        wait(0.1)
        self:setSprite("battle/p1/nailmasters/dashslash_end", 0.05, false, function()
            self.sprite:remove()
        end)
        self.collidable = false
    end)
end

function Dash:draw()
    if self.phase == 1 then
        love.graphics.setColor(1,1,1, self.sprite.alpha/10)
        love.graphics.rectangle("fill", 0,0,80,40)
    end
    super:draw(self)
end

return Dash