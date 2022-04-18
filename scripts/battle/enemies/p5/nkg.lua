local NightmareKing, super = Class("boss")

function NightmareKing:init()
    super:init(self)
    
    self.name = "Nightmare King Grimm"
    self:setActor("p5/nkg")

    self.max_health = 1000
    self.health = 1000

    self.waves = {
        "p5/nkg/fireballs",
        "p5/nkg/spikes",
        "p5/nkg/bats",
        "p5/nkg/pillars",
        "p5/nkg/chase",
    }

    self.text = {
        "* Nightmare binds all.",
        "* Scarlet flames dance around the\nroom.",
        "* Bound by ritual and dream.",
        "* Shadow and fire, dancing and\nfighting.",
    }

    self.double_damage = true

    self.pufferfish = false
end

function NightmareKing:hurt(amount, battler, on_defeat)
    local prev_hp = self.health
    super:hurt(self, amount, battler, on_defeat)
    if prev_hp ~= self.max_health and (self.health % (self.max_health/4) > prev_hp % (self.max_health/4)) then
        self.pufferfish = true
        Game.battle.encounter:advancePhase()
    end
end

function NightmareKing:getNextWaves()
    if self.pufferfish then
        self.pufferfish = false
        return {"p5/nkg/pufferfish"}
    else
        return super:getNextWaves(self)
    end
end

function NightmareKing:dreamDisappear(fake)
    local mask = ColorMaskFX({1,0.5,0.5}, 0)
    self:addFX(mask)
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
            dream.color = {1,0.5,0.5}
            Game.battle:addChild(dream)
        end
        Game.battle.timer:tween(0.5, self.overlay_sprite, {alpha = 0}, "linear", function()
            if not fake then
                self:remove()
            end
        end)
    end)
end

return NightmareKing