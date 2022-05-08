local Nail, super = Class(Soul)

function Nail:init(x, y)
    super:init(self, x, y)

    self.sprite:setSprite("player/nail_soul")
    self.color = {1,1,1}

    self.nail = CircleCollider(self, 0, 0, 32)
    self.nail.collidable = false
    self.nail_timer = Timer()
    self:addChild(self.nail_timer)
    self.cooldown = 0
    self.collided = {}

    self.can_focus = true
    self.focus_cooldown = 0
    self.focus_used = 0

    self.knockback = 0
    self.knockback_dir = nil

    self.focus_ps = ParticleAbsorber(0,0, {
        auto = false,
        alpha = 0.5,
        alpha_var = 0.1,
        size = 4,
        fade_in = 0.2,
        move_time = 0.5,
        dist = 32,
        ease = "in-quad",
        every = 0.2,
        amount = {1,2},
    })
    self:addChild(self.focus_ps)
    self.focus_mask = ColorMaskFX({1,1,1}, 0)
    self:addFX(self.focus_mask)

    self.fury_ps = ParticleEmitter(0,0, {
        auto = false,
        layer = "below_soul",
        shape = "circle",
        color = {1, 0.2, 0.2},
        alpha = 0.2,
        size = {12,16},
        physics = {
            speed = {0.5,1},
            friction = 0.02,
        },
        fade = 0.03,
        fade_after = 0.1,
        amount = {2,3},
        every = 0.15,
    })
    self:addChild(self.fury_ps)
    self.fury_mask = ColorMaskFX({1,0.2,0.2}, 0)
    self:addFX(self.fury_mask)
    self.fury_sine = 0
end

function Nail:update()
    super:update(self)

    self.cooldown = Utils.approach(self.cooldown, 0, DT)
    if not self.transitioning and Input.pressed("confirm") and self.cooldown == 0 then
        self:attack()
    end

    self.focus_cooldown = Utils.approach(self.focus_cooldown, 0, DT)
    local tpbar = Game.battle.tension_bar
    local tp = tpbar:getTension()
    if  Game.battle.state == "DEFENDING" and self.can_focus and Input.down("cancel")
    and self.cooldown == 0 and self.focus_cooldown == 0 and tp >= 16 then
        local speed = self:hasEffect("quickfocus") and 0.8 or 0.5
        self.focus_used = Utils.approach(self.focus_used, 16, speed*DTMULT)
        tpbar:setTensionPreview(self.focus_used)
        self.focus_ps.data.auto = true
        self.focus_mask.amount = Utils.clampMap(self.focus_used, 0,16, 0,0.6)

        if self.focus_used == 16 then
            local player = Game.battle:getPartyBattler("knight")
            player:heal(player.chara:getStat("magic")*2)
            self.focus_cooldown = 0.5
        end
    elseif self.focus_used > 0 then
        if self.focus_used > 6 and Game.battle.state ~= "DEFENDINGEND" then
            tpbar:removeTension(self.focus_used)
        else
            tpbar:setTensionPreview(0)
        end
        self.focus_ps.data.auto = false
        self.focus_ps:clear()
        self.focus_mask.amount = 0
        self.focus_used = 0
    end

    if self:hasEffect("fury") then
        self.fury_ps.data.auto = true
        self.fury_sine = (self.fury_sine + DT) % (math.pi)
    else
        self.fury_ps.data.auto = false
        if self.fury_sine > 0 then
            self.fury_sine = (self.fury_sine + DT)
            if self.fury_sine > math.pi then
                self.fury_sine = 0
            end
        end
    end
    self.fury_mask.amount = math.abs(math.sin(self.fury_sine*2)) * 0.2

    if self.knockback > 0 then
        self:move(math.cos(self.knockback_dir), math.sin(self.knockback_dir), self.knockback*DTMULT)
        self.knockback = Utils.approach(self.knockback, 0, 1*DTMULT)
        if self.knockback == 0 then
            self.knockback_dir = nil
        end
    end

    if self.nail.collidable and Game.battle.waves then
        for _,obj in ipairs(Game.stage:getObjects(Registry.getBullet("nailbase"))) do
            if not self.collided[obj] and self.nail:collidesWith(obj.nail_hb or obj) then
                obj:hit(self)
                self:setKnockback(obj:getPlayerKnockbackDir(self))
                self.collided[obj] = true
            end
        end

        for _,obj in ipairs(Game.stage:getObjects(NailComponent)) do
            if not self.collided[obj] and self.nail:collidesWith(obj.collider or obj.parent) then
                obj:hit(self)
                if obj.knockback then
                    self:setKnockback(obj:knockbackAngle(self))
                end
                self.collided[obj] = true
            end
        end

        -- if Game.battle.arena and not self.collided.arena then
        --     for _,line in ipairs(Game.battle.arena.collider.colliders) do
        --         if self.nail:collidesWith(line) then
        --             local angle = Utils.angle(line.x, line.y, line.x2, line.y2)
        --             local dir = Game.battle.arena.clockwise and -1 or 1
        --             self:setKnockback(angle + dir*math.pi/2)
        --             self.collided.arena = true
        --         end
        --     end
        -- end
    end
end

function Nail:doMovement()
    local tp = Game.battle.tension_bar:getTension()
    if self.can_focus and Input.down("cancel") and self.cooldown == 0 and self.focus_cooldown == 0 and tp >= 16 then
        self.speed = Utils.approach(self.speed, self:hasEffect("unn") and 2 or 0, 1*DTMULT)
    else
        self.speed = 4
    end
    super:doMovement(self)
end

function Nail:onDamage(bullet, amount)
    super:onDamage(self, bullet, amount)
    local last = self.can_focus
    self.can_focus = false
    Game.battle.timer:after(self.inv_timer/2, function()
        self.can_focus = last
    end)
end

function Nail:onRemove(parent)
    if self.focus_used > 0 then
        Game.battle.tension_bar:setTensionPreview(0)
    end
    super:onRemove(self)
end

function Nail:draw()
    super:draw(self)
    if DEBUG_RENDER then
        self.nail:draw(0,0,1, self.nail.collidable and 1 or 0.5)
    end
end

function Nail:attack()
    self.cooldown = self:hasEffect("quickslash") and 0.25 or 0.5
    self.sprite:play(0.05, false, function()
        self.sprite:setSprite("player/nail_soul")
    end)
    Assets.playSound("player/sword_"..Utils.pick{1,2,3,4}, 0.5)
    self.nail_timer:after(0.1, function()
        self.nail.collidable = true
        self.nail_timer:after(0.2, function()
            self.nail.collidable = false
            self.collided = {}
        end)
    end)
end

function Nail:setKnockback(angle)
    if self:hasEffect("steadybody") then return end
    self.knockback = 4
    if self.knockback_dir then
        local angleDiff = Utils.angleDiff(angle, self.knockback_dir)
        self.knockback_dir = angle - angleDiff/2
    else
        self.knockback_dir = angle
    end
end

function Nail:hasEffect(name)
    --do return true end
    if Game.battle.encounter.spells[name] then
        return true
    else
        local player = Game.battle:getPartyBattler("knight")
        if "armors/"..name == player.chara:getArmor(2).id then
            if name == "fury" then
                return player.chara.health <= 15
            else
                return true
            end
        end
    end
    return false
end

return Nail