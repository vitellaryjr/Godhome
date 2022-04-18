local Nightmare, super = Class("ordeal/zotebase")

function Nightmare:init(x, y)
    super:init(self, x, y, "battle/ordeal/nkz_idle")
    self:setHitbox(3,6, 7,27)
    self.health = 300
    self.immune = true
    self.visible = false

    local soul = Game.battle.soul
    if soul.x < self.x then
        self.scale_x = -2
    end

    self.timer = Timer()
    self:addChild(self.timer)
end

function Nightmare:onAdd(parent)
    super:onAdd(self, parent)
    local ps = ParticleAbsorber(self.x, self.y, {
        layer = BATTLE_LAYERS["above_bullets"],
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.7,0.9},
        blend = "screen",
        size = {8,32},
        spin_var = 0.2,
        dist = 48,
        move_time = 0.1,
        fade_in = 0.1,
        amount = {3,4},
        every = 0.01,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    })
    self.wave:addChild(ps)
    self.timer:after(0.3, function()
        ps:remove()
        self.visible = true
        local mask = ColorMaskFX({1,0.8,0.8}, 1)
        self:addFX(mask)
        self.timer:tween(0.5, mask, {amount = 0}, "linear", function()
            self:removeFX(mask)
        end)
    end)

    local arena = Game.battle.arena
    self.timer:script(function(wait)
        wait(1)
        while true do
            local attack = Utils.pick{self.dash, self.fire, self.pillar}
            if self.x < arena.left or self.x > arena.right or self.y > arena.y+20 then
                attack = self.teleport
            end
            local time = attack(self)
            wait(time)
        end
    end)
end

function Nightmare:dash()
    local soul = Game.battle.soul
    self.timer:script(function(wait)
        self:setSprite("battle/ordeal/nkz_dash")
        local angle = Utils.angle(self, soul)
        while Utils.round((self.rotation + math.pi/2) % (math.pi*2), 0.1) ~= Utils.round(angle % (math.pi*2), 0.1) do
            self.rotation = Utils.approachAngle(self.rotation, angle - math.pi/2, 0.3*DTMULT)
            wait()
        end
        wait(0.3)
        self.physics = {
            speed = 14,
            direction = self.rotation + math.pi/2,
        }
        self.timer:everyInstant(0.08, function()
            self.wave:spawnBullet("p5/nkg/fireTrail", self.x, self.y, self.rotation + math.pi/2)
        end, 3)
        wait(0.2)
        self.physics.friction = 2
        while self.physics.speed > 0 do
            wait()
        end
        self:setSprite("battle/ordeal/nkz_idle")
        if soul.x < self.x then
            self.scale_x = -2
        else
            self.scale_x = 2
        end
        self.timer:tween(0.2, self, {rotation = 0})
    end)
    return 1.8
end

function Nightmare:fire()
    local soul = Game.battle.soul
    if soul.x < self.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end
    local prev_side = soul.x < self.x
    self:shiftOrigin(0, 0.5)
    self:setSprite("battle/ordeal/nkz_fire")
    self.timer:after(0.7, function()
        local mask = ColorMaskFX({1,0.8,0.8}, 1)
        self:addFX(mask)
        self.timer:tween(0.5, mask, {amount = 0}, "linear", function()
            self:removeFX(mask)
        end)
        local x, y = self.x + self.scale_x*2, self.y
        local angle = Utils.angle(x, y, soul.x, soul.y)
        if prev_side ~= (soul.x < self.x) then
            angle = Utils.angle(soul.x, y, x, soul.y)
        end
        for i=-1,1 do
            local fireball = self.wave:spawnBullet("battle/p3/grimm/fireball", x, y)
            fireball.sprite:play(0.1, true)
            fireball:setLayer(self.layer + 10)
            fireball.rotation = angle + i*0.5
            fireball.physics = {
                speed = 8,
                match_rotation = true,
            }
        end
        self.timer:after(0.3, function()
            self:setSprite("battle/ordeal/nkz_idle")
            self:shiftOrigin(0.5, 0.5)
        end)
    end)
    return 1.5
end

function Nightmare:pillar()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local time = 2
    local x, y
    if soul.x < arena.x then
        x, y = arena.right - 50, arena.top + 50
    else
        x, y = arena.left + 50, arena.top + 50
    end
    if math.abs(self.x - x) < 50 and math.abs(self.y - y) < 50 then
        self:teleport()
        time = time + 0.6
    end
    self.timer:after(time - 2, function()
        local px, py = soul.x, arena.bottom
        local ps = ParticleEmitter(px, py, {
            shape = "triangle",
            color = {1,0.2,0.2},
            alpha = {0.5,0.8},
            blend = "screen",
            size = {8,32},
            spin_var = 0.2,
            speed = {2,4},
            friction = 0.2,
            fade = 0.04,
            fade_after = 0.1,
            draw = function(p, orig)
                local r, g, b = unpack(p.color)
                local a = p.alpha
                love.graphics.setColor(r*a, g*a, b*a)
                orig:draw(p)
            end,
            mask = true,
            amount = {3,4},
            every = 0.1,
        })
        self.wave:addChild(ps)
        local mask = ColorMaskFX({1,0.8,0.8}, 0)
        self:addFX(mask)
        self.timer:tween(0.7, mask, {amount = 0.8}, "linear", function()
            self:removeFX(mask)
        end)
        self.wave.timer:after(0.7, function()
            ps:clear()
            ps:remove()
            local pillar = self.wave:spawnBulletTo(Game.battle.mask, "p5/nkg/firePillar", px)
            self.wave.timer:after(0.5, function()
                pillar.collidable = false
                self.wave.timer:tween(0.1, pillar, {scale_x = 0}, "linear", function()
                    pillar:remove()
                end)
            end)
        end)
    end)
    return time
end

function Nightmare:teleport()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local x, y
    if soul.x < arena.x then
        x, y = arena.right - 50, arena.top + 50
    else
        x, y = arena.left + 50, arena.top + 50
    end
    local ps = ParticleAbsorber(x, y, {
        layer = BATTLE_LAYERS["above_bullets"],
        shape = "triangle",
        color = {1,0.2,0.2},
        alpha = {0.7,0.9},
        blend = "screen",
        size = {8,32},
        spin_var = 0.2,
        dist = 48,
        move_time = 0.1,
        fade_in = 0.1,
        amount = {3,4},
        every = 0.02,
        draw = function(p, orig)
            local r, g, b = unpack(p.color)
            local a = p.alpha
            love.graphics.setColor(r*a, g*a, b*a)
            orig:draw(p)
        end,
    })
    self.wave:addChild(ps)
    self.timer:tween(0.2, self, {scale_x = 0}, "linear", function()
        ps:remove()
        self:setPosition(x, y)
        if soul.x < self.x then
            self.timer:tween(0.2, self, {scale_x = -2})
        else
            self.timer:tween(0.2, self, {scale_x = 2})
        end
    end)
    return 0.6
end

return Nightmare