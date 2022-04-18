local Pillar, super = Class(Bullet)

function Pillar:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom, "battle/p5/nkg/fire_pillar")
    self.sprite:play(0.1, true)
    self:setOrigin(0.5, 1)
    self:setHitbox(7, 0, 10, 70)
    self.scale_x = 0
end

function Pillar:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.1, self, {scale_x = 2})
    self.wave:addChild(ParticleEmitter(self.x, self.y - 140, 0, 140, {
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.5,0.8},
        blend = "screen",
        size = {8,32},
        spin_var = 0.2,
        speed = {2,4},
        friction = 0.2,
        angle = function(p) return Utils.pick{0, math.pi} end,
        fade = 0.04,
        fade_after = 0.1,
        amount = {16,20},
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    }))
end

return Pillar