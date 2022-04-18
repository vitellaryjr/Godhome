local FailedChamp, super = Class("boss")

function FailedChamp:init()
    super:init(self)

    self.name = "Failed Champion"
    self:setActor("p4/failedchamp")

    self.max_health = 150
    self.health = 150
    
    self.text = {
        "* Failed Champion isn't scared.",
        "* Hegemol is disappointed in Failed\nChampion.",
        "* Strength isn't enough to save you.",
    }

    self.waves = {
        "p4/failedchamp/maceCircle",
        "p4/failedchamp/maceStab",
    }

    self.proj_hb = CircleCollider(self, 46, 46, 25)

    self.armor_health = 400
    self.phase = 1
end

function FailedChamp:getAttackTension()
    return 0
end

function FailedChamp:hurt(amount, battler, by_nail)
    if self.armor_health > 0 then
        self.armor_health = Utils.approach(self.armor_health, 0, amount)
        if not by_nail then
            self:statusMessage("damage", amount, battler and (battler.chara.dmg_color or battler.chara.color))
        end
        if self.armor_health == 0 then
            if #Game.battle.waves > 0 then
                for _,wave in ipairs(Game.battle.waves) do
                    wave.finished = true
                end
            else
                Game.battle.encounter.skip_turn = true
            end
            self:setAnimation("fall")
        end
        self.hurt_timer = by_nail and 0.5 or 0.8
        self.sprite.shake_x = 5
    else
        Game.battle.encounter.skip_turn = false
        self.health = self.health - 50
        if not by_nail then
            self:statusMessage("damage", amount, battler and (battler.chara.dmg_color or battler.chara.color))
        end
        self.hurt_timer = 1
        self.sprite.shake_x = 9

        if self.health <= 0 then
            self:onDefeat()
            self.overlay_sprite:setAnimation("fall_idle")
        else
            self.phase = self.phase + 1
            self.armor_health = 400
            self.angry = true
            self:setAnimation("idle")
            if self.phase == 2 then
                Game.battle.encounter.ps.data.auto = true
            elseif self.phase == 3 then
                Game.battle.encounter.ps.data.every = 0.1
            end
        end
    end
end

function FailedChamp:onNailHurt(amount, battler)
    self:hurt(amount, battler, true)
end

function FailedChamp:getNextWaves()
    if self.angry then
        self.angry = false
        return {"p4/failedchamp/angry"}
    end
    return super:getNextWaves(self)
end

return FailedChamp