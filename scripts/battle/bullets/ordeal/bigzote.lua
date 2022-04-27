local BIGZOTE, super = Class("ordeal/zotebase")

function BIGZOTE:init(x)
    super:init(self, x, -50, "battle/ordeal/bigzote_head")
    self.layer = BATTLE_LAYERS["below_bullets"]
    self.sprite:play(0.4, true)
    self.sprite:setRotationOrigin(0.5, 1)
    self.health = 570
    self.immune = true

    local arena, soul = Game.battle.arena, Game.battle.soul
    if soul.x < arena.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end

    -- lots of body parts to set up
    self.parts = {}

    self.body = Sprite("battle/ordeal/bigzote_body", -1, 18)
    self.body.layer = -5
    self.body.inherit_color = true
    self.body:setRotationOrigin(1, 0.5)
    self.body.swinging = true
    self.body.swing_origin = 0
    self.body.swing_range = 0.18
    self.body.swing_speed = 4.5
    self:addChild(self.body)
    table.insert(self.parts, self.body)

    self.leg_a = Sprite("battle/ordeal/bigzote_leg_left", 3, 45)
    self.leg_a.layer = -10
    self.leg_a.inherit_color = true
    self.leg_a:setRotationOrigin(0.5, 0)
    self.leg_a.swinging = true
    self.leg_a.swing_origin = 0
    self.leg_a.swing_range = 0.1
    self.leg_a.swing_speed = Utils.random(3,4)
    self:addChild(self.leg_a)
    table.insert(self.parts, self.leg_a)

    self.leg_b = Sprite("battle/ordeal/bigzote_leg_right", 13, 45)
    self.leg_b.layer = -10
    self.leg_b.inherit_color = true
    self.leg_b:setRotationOrigin(0.5, 0)
    self.leg_b.swinging = true
    self.leg_b.swing_origin = 0
    self.leg_b.swing_range = 0.1
    self.leg_b.swing_speed = Utils.random(3,4)
    self:addChild(self.leg_b)
    table.insert(self.parts, self.leg_b)

    self.arm = Sprite("battle/ordeal/bigzote_arm", 1, 24)
    self.arm.layer = -4
    self.arm.inherit_color = true
    self.arm:setRotationOrigin(1, 0)
    self.arm.swinging = true
    self.arm.swing_origin = 0
    self.arm.swing_range = 0.1
    self.arm.swing_speed = Utils.random(3,4)
    self:addChild(self.arm)
    table.insert(self.parts, self.arm)

    self.cannon = Sprite("battle/ordeal/bigzote_cannon", 20, 16)
    self.cannon.layer = -12
    self.cannon.inherit_color = true
    self.cannon:setRotationOrigin(0, 0.5)
    self.cannon.swinging = true
    self.cannon.swing_origin = math.pi/2
    self.cannon.swing_range = 0.15
    self.cannon.swing_speed = Utils.random(3,4)
    self:addChild(self.cannon)
    table.insert(self.parts, self.cannon)

    self.cannon_end = Object(34, 7.5)
    self.cannon:addChild(self.cannon_end)

    self.wing_a = Sprite("battle/ordeal/bigzote_wing_a", -42, -2)
    self.wing_a.layer = 1
    self.wing_a.inherit_color = true
    self.wing_a.alpha = 0.75
    self.wing_a:setRotationOrigin(1, 0.5)
    self.wing_a.swinging = true
    self.wing_a.swing_origin = 0
    self.wing_a.swing_range = 0.2
    self.wing_a.swing_speed = 5
    self:addChild(self.wing_a)
    table.insert(self.parts, self.wing_a)

    self.wing_b = Sprite("battle/ordeal/bigzote_wing_b", 11, -2)
    self.wing_b.layer = -15
    self.wing_b.inherit_color = true
    self.wing_b.alpha = 0.5
    self.wing_b:setRotationOrigin(0, 0.5)
    self.wing_b.swinging = true
    self.wing_b.swing_origin = 0
    self.wing_b.swing_range = 0.15
    self.wing_b.swing_speed = 2
    self:addChild(self.wing_b)
    table.insert(self.parts, self.wing_b)

    self.lines = {}
    for i=1,4 do
        local x = i*2.5 + 3
        local line = Sprite("battle/ordeal/bigzote_line", x, -170)
        line.layer = -20
        line.inherit_color = true
        line.alpha = 0.75
        line:setScaleOrigin(0.5, 0)
        line:setRotationOrigin(0.5, 0)
        line.swinging = true
        line.swing_origin = 0
        line.swing_range = Utils.random(0.01)
        line.swing_speed = Utils.random(1,2)
        self:addChild(line)
        table.insert(self.lines, line)
        table.insert(self.parts, line)
    end
    for i=1,5 do
        local x = i*2 + 3
        local line = Sprite("battle/ordeal/bigzote_line", x, -170)
        line.layer = -21
        line.inherit_color = true
        line.alpha = 0.25
        line:setScaleOrigin(0.5, 0)
        line.scale_x = 0.5
        line:setRotationOrigin(0.5, 0)
        line.swinging = true
        line.swing_origin = 0
        line.swing_range = Utils.random(0.005)
        line.swing_speed = Utils.random(1)
        self:addChild(line)
        table.insert(self.lines, line)
        table.insert(self.parts, line)
    end

    -- okay that's all

    self.cannon.collider = Hitbox(self.cannon, 6,5, 27,5)
    self.cannon.collider.collidable = false
    self.collider = ColliderGroup(self, {
        Hitbox(self, 5,10, 10,50),
        self.cannon.collider,
    })
    self.nail_hb = ColliderGroup(self, {
        Hitbox(self, 0,10, 20,60),
        Hitbox(self.cannon, 6,5, 27,5),
        Hitbox(self, 5,-200, 10,210),
    })

    self.timer = Timer()
    self:addChild(self.timer)

    self.sine = Utils.random(100)
    self.hoppers = {}

    self.timer:tween(0.5, self, {y = arena.top + 20}, "out-quad")
    self:attackScript()
end

function BIGZOTE:update()
    super:update(self)
    self.sine = self.sine + DT
    for _,part in ipairs(self.parts) do
        if part.swinging then
            part.rotation = math.sin(self.sine*part.swing_speed)*part.swing_range + part.swing_origin
        elseif part.shaking then
            part.rotation = part.swing_origin + math.sin(self.sine*20)*0.03
        end
    end
end

function BIGZOTE:attackScript()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.timer:script(function(wait)
        wait(2)
        local prev_attack
        while true do
            local attack = Utils.pick({"cannon", "cannon", "heart", "hopper", "phone"}, function(v)
                if v == "cannon" and math.abs(soul.x - self.x) < 60 and math.abs(arena.x - self.x) > 120 then
                    return false
                elseif v == "hopper" and (#self.hoppers > 0 or math.abs(self.x - arena.x) < 40) then
                    return false
                elseif v == "phone" and prev_attack == "phone" then
                    return false
                end
                return true
            end)

            if prev_attack == "cannon" and attack ~= "cannon" then
                self.timer:tween(0.2, self.cannon, {rotation = math.sin(self.sine*self.cannon.swing_speed)*self.cannon.swing_range + math.pi/2}, "out-back")
                wait(0.3)
                self.cannon.swinging = true
            elseif prev_attack == "heart" and attack ~= "heart" then
                if self.x < arena.left + 40 then
                    self.timer:tween(0.5, self, {x = arena.left + 40}, "out-quad")
                    wait(0.7)
                elseif self.x > arena.right - 40 then
                    self.timer:tween(0.5, self, {x = arena.right - 40}, "out-quad")
                    wait(0.7)
                end
            end

            if attack == "cannon" then
                if math.abs(soul.x - self.x) < 60 then
                    self.timer:tween(0.5, self, {x = arena.x - 120*Utils.sign(soul.x - self.x)}, "out-quad")
                    wait(0.3)
                end
                if soul.x < self.x then
                    self.scale_x = -2
                else
                    self.scale_x = 2
                end
                self.cannon.swinging = false
                local sx, sy = soul.x, soul.y
                if self.x < soul.x then
                    angle = Utils.angle(self.x + self.cannon.x, self.y + self.cannon.y, sx, sy)
                else
                    angle = Utils.angle(sx, self.y + self.cannon.y, self.x + self.cannon.x, sy)
                end
                self.timer:tween(0.4, self.cannon, {rotation = angle}, "out-back")
                wait(0.6)
                local ix, iy = self.cannon_end:getRelativePos(0,0, Game.battle)
                local blob = self.wave:spawnBullet("common/infection", ix, iy)
                blob.physics = {
                    speed_x = 8*math.cos(self.cannon.rotation)*Utils.sign(self.scale_x),
                    speed_y = 8*math.sin(self.cannon.rotation),
                    gravity = 0.03,
                    gravity_direction = math.pi/2,
                }
                wait(0.5)
            elseif attack == "heart" then
                if soul.x < self.x then
                    self.scale_x = -2
                else
                    self.scale_x = 2
                end
                local nx = Utils.clamp(soul.x - 250*Utils.sign(soul.x - self.x), 100, 540)
                if math.abs(soul.x - nx) > math.abs(soul.x - self.x) then
                    self.timer:tween(0.5, self, {x = nx}, "out-quad")
                    wait(0.3)
                end
                self.sprite:stop()
                self.sprite:setFrame(1)
                self.timer:tween(0.2, self.sprite, {rotation = math.pi/4}, "out-quad")
                self.body.swinging = false
                self.timer:tween(0.2, self.body, {rotation = math.pi/6}, "out-quad")
                self.leg_a.swinging = false
                self.timer:tween(0.2, self.leg_a, {rotation = -math.pi/6}, "out-quad")
                self.leg_b.swinging = false
                self.timer:tween(0.2, self.leg_b, {rotation = -math.pi/6}, "out-quad")
                self.arm.swinging = false
                self.timer:tween(0.2, self.arm, {rotation = math.pi/4, y = 28}, "out-quad")
                self.cannon.swinging = false
                self.timer:tween(0.2, self.cannon, {rotation = math.pi*2/3}, "out-quad")
                wait(0.5)
                self.timer:tween(0.2, self.sprite, {rotation = -math.pi/4}, "out-back")
                self.timer:tween(0.2, self.body, {rotation = -math.pi/6, y = 8}, "out-back")
                self.timer:tween(0.2, self.leg_a, {swing_origin = math.pi/6}, "out-back")
                self.leg_a.shaking = true
                self.timer:tween(0.2, self.leg_b, {swing_origin = math.pi/6}, "out-back")
                self.leg_b.shaking = true
                self.timer:tween(0.2, self.arm, {swing_origin = math.pi/3}, "out-back")
                self.arm.shaking = true
                self.timer:tween(0.2, self.cannon, {swing_origin = math.pi*5/6}, "out-back")
                self.cannon.shaking = true
                local sx, sy = self.x + 15, self.y + 30
                local dir = (soul.x < self.x) and math.pi or 0
                self.heart = self.wave:spawnBullet("ordeal/bigzote_heart", sx, sy, dir)
                table.insert(self.nail_hb.colliders, self.heart.collider)
                local tx, ty = self.x + 150*Utils.sign(self.scale_x), love.math.random(arena.top, arena.bottom)
                self.timer:tween(0.6, self.heart, {x = tx, y = ty}, "out-quad")
                self.chains = {}
                for i=0,8 do
                    local chain = Sprite("battle/ordeal/bigzote_heart_chain", sx, sy)
                    chain:setLayer(BATTLE_LAYERS["below_bullets"] + 10)
                    chain:setOrigin(0.5, 0.5)
                    chain:setScale(1)
                    chain.color = {1, 0.8, 0.5}
                    Game.battle:addChild(chain)
                    table.insert(self.chains, chain)
                    local lx, ly = Utils.round(Utils.lerp(sx, tx, i/9)), Utils.round(Utils.lerp(sy, ty, i/10))
                    self.timer:tween(0.6, chain, {x = lx, y = ly}, "out-quad")
                end
                wait(0.6)
                self.heart:fire()
                wait(0.1)
                self.timer:tween(0.6, self.heart, {x = sx, y = sy}, "in-quad")
                for _,chain in ipairs(self.chains) do
                    self.timer:tween(0.6, chain, {x = sx, y = sy}, "in-quad")
                end
                wait(0.5)
                self.timer:tween(0.1, self.heart, {scale_x = 0.5, scale_y = 0.5})
                wait(0.1)
                self.heart:remove()
                Utils.removeFromTable(self.nail_hb.colliders, self.heart.collider)
                self.heart = nil
                for _,chain in ipairs(self.chains) do
                    chain:remove()
                end
                self.chains = nil
                self.sprite.rotation = math.pi/4
                self.timer:tween(0.2, self.sprite, {rotation = 0}, "out-quad")
                self.body.swing_origin = math.pi/6
                self.body.swinging = true
                self.body.shaking = false
                self.timer:tween(0.2, self.body, {swing_origin = 0, y = 18}, "out-quad")
                self.leg_a.swing_origin = -math.pi/6
                self.leg_a.swinging = true
                self.leg_a.shaking = false
                self.timer:tween(0.2, self.leg_a, {swing_origin = 0}, "out-quad")
                self.leg_b.swing_origin = -math.pi/6
                self.leg_b.swinging = true
                self.leg_b.shaking = false
                self.timer:tween(0.2, self.leg_b, {swing_origin = 0}, "out-quad")
                self.arm.swing_origin = math.pi/4
                self.arm.swinging = true
                self.arm.shaking = false
                self.timer:tween(0.2, self.arm, {swing_origin = 0, y = 24}, "out-quad")
                self.cannon.swing_origin = math.pi*2/3
                self.cannon.swinging = true
                self.cannon.shaking = false
                self.timer:tween(0.2, self.cannon, {swing_origin = math.pi/2}, "out-quad")
                self.sprite:play(0.4, true)
                wait(0.5)
            elseif attack == "hopper" then
                if self.x < arena.x then
                    self.scale_x = 2
                    self.timer:tween(0.5, self, {x = arena.left, y = love.math.random(arena.top + 40, arena.bottom - 40)}, "out-quad")
                else
                    self.scale_x = -2
                    self.timer:tween(0.5, self, {x = arena.right, y = love.math.random(arena.top + 40, arena.bottom - 40)}, "out-quad")
                end
                wait(0.7)
                self.sprite:setSprite("battle/ordeal/bigzote_head_grow")
                self.sprite:play(0.1, false)
                self.sprite:setPosition(0, -16)
                wait(0.5)
                self.sprite:setSprite("battle/ordeal/bigzote_head_open")
                self.sprite:play(0.07, false)
                wait(0.5)
                table.insert(self.hoppers, self.wave:spawnBullet("ordeal/bigzote_hopper", self.x, self.y, 3*Utils.sign(self.scale_x), self))
                wait(1)
                self.sprite:setSprite("battle/ordeal/bigzote_head_close")
                self.sprite:play(0.1, false, function()
                    self.sprite:setSprite("battle/ordeal/bigzote_head")
                    self.sprite:play(0.4, true)
                    self.sprite:setPosition(0, 0)
                end)
                wait(1)
            elseif attack == "phone" then
                if soul.x > self.x then
                    self.scale_x = 2
                else
                    self.scale_x = -2
                end
                self.timer:tween(0.5, self, {y = arena.top + 50}, "out-quad")
                if  math.abs(self.x - arena.x) > 80
                and Utils.sign(self.x - arena.x) == Utils.sign(soul.x - arena.x)
                and math.abs(self.x - arena.x) < math.abs(soul.x - arena.x) then
                    self.timer:tween(0.5, self, {x = arena.x}, "out-quad")
                    wait(0.5)
                end
                self.cannon.swinging = false
                self.physics = {
                    speed_x = 1*Utils.sign(self.scale_x),
                }
                for _=1,3 do
                    self.timer:tween(0.4, self.cannon, {rotation = Utils.random(-math.pi/2 + 0.2, -math.pi/3)}, "out-back")
                    wait(0.5)
                    self.cannon.collider.collidable = true
                    local ix, iy = self.cannon_end:getRelativePos(0,0, Game.battle)
                    local orb = Sprite("battle/ordeal/bigzote_orb", ix, iy)
                    orb.layer = BATTLE_LAYERS["bullets"]
                    orb:setOrigin(0.5, 0.5)
                    orb:setScale(2)
                    orb.physics = {
                        speed_y = -8,
                    }
                    Game.battle:addChild(orb)
                    self.wave.timer:tween(0.7, orb, {x = self.x + math.cos(self.cannon.rotation)*arena.width * Utils.sign(self.scale_x)}, "out-quad")
                    self.wave.timer:tween(0.7, orb.physics, {speed_y = 0}, "out-quad")
                    self.wave.timer:script(function(_wait)
                        _wait(0.4)
                        local mask = ColorMaskFX({1,1,0}, 1)
                        orb:addFX(mask)
                        self.wave.timer:tween(0.2, mask, {amount = 0})
                        _wait(0.4)
                        for i=-1,1 do
                            local soundwave = self.wave:spawnBullet("battle/ordeal/bigzote_soundwave", orb.x, orb.y)
                            soundwave:setScale(1)
                            soundwave.rotation = math.pi/2 + i*0.5
                            soundwave.physics = {
                                speed = 8,
                                match_rotation = true,
                            }
                        end
                        orb:remove()
                    end)
                    wait(0.9)
                end
                self.cannon.collider.collidable = false
                self.physics = {}
                self.cannon.swing_origin = self.cannon.rotation
                self.cannon.swinging = true
                self.timer:tween(0.4, self.cannon, {swing_origin = math.pi/2}, "out-back")
                wait(0.7)
            else
                wait()
            end

            if attack then
                prev_attack = attack
            end
        end
    end)
end

function BIGZOTE:onDefeat()
    super:onDefeat(self)
    if self.heart then self.heart:remove() end
    if self.chains then
        for _,chain in ipairs(self.chains) do
            chain:remove()
        end
    end
end

function BIGZOTE:killAnim()
    self.timer:remove()
    for _,line in ipairs(self.lines) do
        self.wave.timer:tween(Utils.random(0.1,0.2), line, {scale_y = 0}, "linear", function()
            line:remove()
        end)
    end
    for _,part in ipairs(self.parts) do
        part.swinging = false
    end
    self.sprite:stop()
    self.sprite:setFrame(1)
    self.collidable = false
    self.graphics.spin = -0.01
    self.physics = {
        speed_y = 2,
        gravity = 0.8,
        gravity_direction = math.pi/2,
    }
    self.wave.timer:after(2, function()
        self:remove()
    end)
end

return BIGZOTE