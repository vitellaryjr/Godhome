local NailBullet, super = Class(Bullet)

function NailBullet:init(x, y, texture)
    super:init(self, x, y, texture)
    self.color = {1, 0.8, 0.5}
    self.tp = 0 -- grazing is off by default, because hitting with a nail grants tp

    -- if set to an enemy, the enemy will be hurt when the bullet is hit
    self.enemy = nil
    -- if self.enemy is not specified, then the bullet will have this much health
    -- -1 means it doesn't take damage
    self.health = -1

    -- can be defined for specific hitbox
    self.nail_hb = nil
    -- how much tp the player gets from hitting it
    self.nail_tp = 1.6
    -- if defined, overrides how much tp the player gets from hitting an enemy bullet
    self.enemy_tp = nil

    -- how fast the bullet will be moved when hit
    self.knockback = 0
    -- set to self.knockback when hit
    self.curr_knockback = 0
    -- how fast the bullet recovers from knockback
    self.knockback_recover = 0.5
    -- direction the bullet will move when hit (automatically set)
    self.knockback_dir = 0
    -- color the bullet will flash to (nil means no flash)
    self.nail_flash = {1,1,1}
    -- sfx path and volume to play when hit
    self.hit_sfx = "player/enemy_damage"
    self.hit_volume = 0.5
end

function NailBullet:onAdd(parent)
    super:onAdd(self, parent)
    self.base_color = Utils.copy(self.color)
end

function NailBullet:update()
    super:update(self)

    if self.curr_knockback > 0 then
        self:move(math.cos(self.knockback_dir), math.sin(self.knockback_dir), self.curr_knockback*DTMULT)
        self.curr_knockback = Utils.approach(self.curr_knockback, 0, self.knockback_recover*DTMULT)
    end
end

function NailBullet:draw()
    super:draw(self)
    if DEBUG_RENDER and self.nail_hb then
        self.nail_hb:draw(0,1,1)
    end
end

function NailBullet:hit(source, damage) -- source can be any object
    if self.knockback > 0 then
        self.curr_knockback = self.knockback
        self.knockback_dir = self:getKnockbackDir(source)
    end

    if self.enemy then
        local tp = self.enemy_tp or self.enemy:getAttackTension(15)
        Game:giveTension(tp)
    elseif self.nail_tp > 0 then
        local tp = Game:getFlag("bindings", {}).magic and (self.nail_tp*0.25) or self.nail_tp
        Game:giveTension(tp)
    end

    if self.nail_flash then
        self.color = Utils.copy(self.nail_flash)
        self.wave.timer:tween(0.5, self, {color = self.base_color})
    end
    Assets.playSound(self.hit_sfx, self.hit_volume)

    local player = Game.battle:getPartyBattler("knight")
    damage = damage or self:getPlayerDamage(player.chara)
    self:hurt(damage, player)
end

function NailBullet:getKnockbackDir(source)
    return Utils.angle(source.x, source.y, self.x, self.y)
end

function NailBullet:getPlayerKnockbackDir(source)
    return Utils.angle(self.x, self.y, source.x, source.y)
end

function NailBullet:getPlayerDamage(player, enemy)
    local atk = player:getStat("attack")/5 * 7.5
    enemy = enemy or self.enemy
    local def = (enemy and enemy.defense or 0) * 3
    local result = Utils.round(atk - def)
    -- print(result)
    return result
end

function NailBullet:hurt(amount, player)
    if self.enemy then
        if self.enemy.onNailHurt then
            self.enemy:onNailHurt(amount, player)
        else
            self.enemy.health = self.enemy.health - amount
            self.enemy.hurt_timer = 0.5
            self.enemy.sprite.shake_x = 7
        end
        if self.enemy.health <= 0 then
            self:onDefeat()
        end
    elseif self.health > 0 then
        self.health = self.health - amount
        if self.health <= 0 then
            self:onDefeat()
        end
    end
end

function NailBullet:onDefeat()
    self:remove()
    if self.enemy then
        self.enemy:onDefeat()
    end
end

return NailBullet