local Ooma, super = Class("projbase")

function Ooma:init(x, y)
    super:init(self, x, y, "battle/p3/uumuu/ooma")
    self.layer = BATTLE_LAYERS["below_ui"]
    self.sprite:play(0.2, true)
    self:setOriginExact(8, 9)
    self.collider = CircleCollider(self, 8, 9, 4)
    self.physics.speed_y = -2

    self.starting = false
end

function Ooma:update()
    super:update(self)
    if self.layer == BATTLE_LAYERS["below_ui"] and self.y < 280 then
        self:setLayer(BATTLE_LAYERS["bullets"])
    end
    if self.launched then
        local soul = Game.battle.soul
        local angle = Utils.angle(self, soul)
        if self.starting and self.physics.speed == 0 then
            self.rotation = angle
            self.physics = {
                speed = 0,
                match_rotation = true,
            }
            self.wave.timer:tween(0.3, self.physics, {speed = 20})
            self.starting = false
        elseif not self.starting then
            self.rotation = Utils.approachAngle(self.rotation, angle, 0.02*DTMULT)
        end
    end
end

function Ooma:onDamage(soul)
    if self.launched then
        self:spawnExplosion()
    else
        super:onDamage(self, soul)
    end
end

function Ooma:hit(source, damage)
    self:setSprite("battle/p3/uumuu/ooma_core", 0.1, true)
    self.collider = CircleCollider(self, 8.5, 7.5, 2)
    self.rotation = Utils.angle(source, self)
    self.physics = {
        speed = 15,
        friction = 0.7,
        match_rotation = true,
    }
    self.tp = 1.6
    self.starting = true
    super:hit(self, source, damage)
end

function Ooma:launchHit(battler)
    local exp = self:spawnExplosion()
    exp.collidable = false
    if battler:includes(PartyBattler) then
        battler:hurt(exp:getDamage())
        Game.battle.shake = 8
        local i = 0
        Game.battle:addChild(ParticleEmitter(battler.x, battler.y - 40, {
            layer = BATTLE_LAYERS["above_battlers"],
            shape = "circle",
            color = {0,0,0},
            scale_var = 0.1,
            speed = 2,
            fade = 0.1,
            fade_after = 0.1,
            angle = function(p)
                i = i + math.pi/10
                return i
            end,
            angle_var = 0.15,
            dist = 32,
            amount = 20,
        }))
        local fx = Sprite("battle/misc/heavy_damage_ui")
        fx.layer = BATTLE_LAYERS["top"] + 1000
        fx.alpha = 1
        Game.battle:addChild(fx)
        fx:fadeOutAndRemove(0.1)
    elseif battler:includes(EnemyBattler) then
        battler.health = battler.health - 100
        battler.hurt_timer = 0.5
        battler.sprite.shake_x = 8
        battler:setAnimation("vulnerable")
        battler:flash()
        battler.defense = 1
        Game.battle.encounter.vuln_count = 3
        self.wave.finished = true
    end
end

function Ooma:spawnExplosion()
    local exp = self.wave:spawnBullet("common/explosion", self.x, self.y, 40)
    if love.math.random() < 0.001 then
        exp.visible = false
        self:explode()
    else
        self:remove()
    end
    return exp
end

return Ooma