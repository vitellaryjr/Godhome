local Grimm, super = Class("boss")

function Grimm:init()
    super:init(self)
    
    self.name = "Troupe Master Grimm"
    self:setActor("p3/grimm")

    self.max_health = 750
    self.health = 750

    self.waves = {
        "p3/grimm/fireballs",
        "p3/grimm/chase",
        "p3/grimm/spikes",
        "p3/grimm/bats",
    }

    self.text = {
        "* The Grimm Troupe is honored to be\nhere.",
        "* Grimm is the only one that knows\nwhat's going on here.",
        "* Call and serve in Grimm's dread\nTroupe.",
        "* The flames are whispering to you.",
    }

    self.pufferfish = false
end

function Grimm:hurt(amount, battler, on_defeat)
    local prev_hp = self.health
    super:hurt(self, amount, battler, on_defeat)
    if self.pufferfish then return end
    if Game.battle.encounter.bowing
    or (prev_hp ~= self.max_health and (self.health % (self.max_health/3) > prev_hp % (self.max_health/3))) then
        self.pufferfish = true
        if Game.battle.encounter.bowing then
            Game.battle.encounter.bowing = false
            self.sprite:setAnimation("scream")
            Assets.playSound("bosses/grimm_scream")
            Game.battle.encounter.extra_layer:fade(1, 1)
            Game.battle.shake = 4
            Game.battle.timer:after(1.5, function()
                self.sprite:setAnimation("scream_end")
            end)
        end
    end
end

function Grimm:getNextWaves()
    if self.pufferfish then
        self.pufferfish = false
        return {"p3/grimm/pufferfish"}
    else
        return super:getNextWaves(self)
    end
end

function Grimm:dreamDisappear(fake)
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

return Grimm