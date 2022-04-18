local FalseKnight, super = Class("boss")

function FalseKnight:init()
    super:init(self)

    self.name = "False Knight"
    self:setActor("p1/falseknight")

    self.max_health = 150
    self.health = 150
    
    self.text = {
        "* Hegemol died long ago.",
        "* The floor is cracked.",
        "* Whimpers echo from within the armor.",
        "* False Knight pretends not to be\nscared.",
    }

    self.proj_hb = CircleCollider(self, 46, 46, 25)

    self.armor_health = 300
    self.phase = 1
end

function FalseKnight:getAttackTension()
    return 0
end

function FalseKnight:hurt(amount, battler, on_defeat)
    if self.armor_health > 0 then
        self.armor_health = Utils.approach(self.armor_health, 0, amount)
        self:statusMessage("damage", amount, battler and (battler.chara.dmg_color or battler.chara.color))
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
        self.hurt_timer = 0.8
        self.sprite.shake_x = 5
    else
        Game.battle.encounter.skip_turn = false
        self.health = self.health - 50
        self:statusMessage("damage", amount, battler and (battler.chara.dmg_color or battler.chara.color))
        self.hurt_timer = 1
        self.sprite.shake_x = 9

        if self.health <= 0 then
            self:onDefeat()
            self.overlay_sprite:setAnimation("fall_idle")
        else
            self.phase = self.phase + 1
            self.armor_health = 300
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

function FalseKnight:onNailHurt(amount, battler)
    self.armor_health = self.armor_health - amount
    self.hurt_timer = 0.5
    self.sprite.shake_x = 7
end

function FalseKnight:getNextWaves()
    if self.angry then
        self.angry = false
        return {"p1/falseknight/"..self.phase.."/angry"}
    end
    return {
        "p1/falseknight/"..self.phase.."/maceCircle",
        "p1/falseknight/"..self.phase.."/maceStab",
    }
end

return FalseKnight