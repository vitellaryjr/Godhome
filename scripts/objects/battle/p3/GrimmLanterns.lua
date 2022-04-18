local Lantern, L_super = Class(Sprite)

function Lantern:init(x, y)
    L_super:init(self, "battle/p3/grimm/bg_lantern", x, y)
    self:setScale(2)
    self:setOrigin(0.5, 0.5)

    Game.battle:addChild(ParticleEmitter(self.x, self.y, {
        layer = BATTLE_LAYERS["bottom"] + 95,
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.2, 0.3},
        blend = "screen",
        size = {16,24},
        speed = {0, 0.5},
        spin_var = 0.2,
        fade_in = 0.1,
        fade = 0.04,
        fade_after = 0.2,
        amount = {2,3},
        every = 0.2,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    }))
    Game.battle:addChild(ParticleEmitter(self.x, self.y, {
        layer = BATTLE_LAYERS["bottom"] + 105,
        shape = "circle",
        color = {1,0.2,0.2},
        alpha = {0.5, 0.8},
        blend = "screen",
        size = {4,6},
        speed = {0,3},
        angle = -math.pi/2,
        angle_var = 0.3,
        gravity = 0.05,
        gravity_direction = -math.pi/2,
        spin_var = 0.2,
        fade = 0.04,
        fade_after = 0.1,
        amount = {1,2},
        every = 0.5,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    }))
end

function Lantern:draw()
    L_super:draw(self)
    love.graphics.setColor(0.25, 0.08, 0.09)
    for i=0,10 do
        local y = -18 - i*4
        love.graphics.circle("fill", self.width/2, self.height/2 + y, 2)
    end
end

local BG, B_super = Class(Object)

function BG:init()
    B_super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 100
    self:addChild(Lantern(180, 80))
    self:addChild(Lantern(460, 60))
end

return BG