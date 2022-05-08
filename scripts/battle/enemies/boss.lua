local Boss, super = Class(EnemyBattler)

function Boss:init()
    super:init(self)

    self.attack = 5
    self.defense = 1

    self.dialogue = {}
    self.tired_percentage = -1

    self.seen_waves = {}
end

function Boss:onAdd(parent)
    super:onAdd(self, parent)
    if not self.proj_hb and self.sprite then
        self.proj_hb = Hitbox(self, 0, 0, self.sprite.width, self.sprite.height)
    end
    if self.encounter.difficulty and self.encounter.difficulty > 2 then
        local ratio = self.health / self.max_health
        self.max_health = self.asc_health or (self.max_health*1.5)
        self.health = ratio * self.max_health
    end
end

function Boss:draw()
    super:draw(self)
    if DEBUG_RENDER and self.proj_hb then
        self.proj_hb:draw(1,0,0)
    end
end

function Boss:onDefeat(damage, battler)
    self.hurt_timer = -1
    self:toggleOverlay(true)
    if self.actor.animations["defeat"] then
        self.overlay_sprite:setAnimation("defeat")
    else
        self.overlay_sprite:setAnimation("hurt")
    end
    self.encounter:removeBoss(self)
    if #self.encounter.bosses == 0 then
        self.encounter:dreamEnd()
    end
    Game.battle.timer:after(0.7, function()
        self:dreamDisappear()
    end)
end

function Boss:getNextWaves()
    -- healing tutorial
    local knight = Game.battle:getPartyBattler("knight")
    if knight.chara.health < knight.chara.stats.health and not Game:getFlag("taught_healing", false) then
        Game:setFlag("taught_healing", true)
        Game.battle:infoText("* Press "..Input.getText("cancel").." while at 16% TP to heal!")
    end

    local waves = Utils.filter(self.waves, function(v) return not self.seen_waves[v] end)
    if #waves > 0 then
        return waves
    else
        return self.waves
    end
end

function Boss:selectWave()
    local wave = super:selectWave(self)
    if wave then
        self.seen_waves[wave] = true
    end
    return wave
end

function Boss:onNailHurt(amount, battler)
    self.health = self.health - amount
    self.hurt_timer = 0.5
    self.sprite.shake_x = 7
end

function Boss:dreamDisappear(fake)
    local mask = ColorMaskFX({1,1,1}, 0)
    self:addFX(mask, "dream_disappear")
    Assets.playSound("bosses/boss_defeat")
    Game.battle.timer:tween(0.1, mask, {amount = 1}, "linear", function()
        local num = Utils.round((self.overlay_sprite.width*self.overlay_sprite.height)/80)
        for _=1,num do
            local sx, sy = self.overlay_sprite:getScreenPos()
            local w = self.overlay_sprite.width*self.scale_x
            local h = self.overlay_sprite.height*self.scale_y

            local x = sx + Utils.clampMap(love.math.random(w), 0,w, 0,w, "out-in-sine")
            local y = sy + love.math.random(h)
            local dream = EnemyDream(x, y)
            Game.battle:addChild(dream)
        end
        Game.battle.timer:tween(0.5, self.overlay_sprite, {alpha = 0}, "linear", function()
            if not fake then
                self:remove()
            end
        end)
    end)
end

return Boss