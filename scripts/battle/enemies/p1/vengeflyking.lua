local VengeflyKing, super = Class("boss")

function VengeflyKing:init()
    super:init(self)

    self.name = "Vengefly King"
    self:setActor("p1/vengeflyking")

    self.max_health = 400
    self.health = 400

    self.waves = {
        "p1/vengeflyking/vengeflies",
        "p1/vengeflyking/charge",
    }
    
    self.text = {
        "* Vengefly King screeches loudly.",
        "* Vengefly King chews on a bone.",
        "* Vengeflies are awaiting their King's\ncommand.",
    }
end

function VengeflyKing:getNextWaves()
    if not Game:getFlag("taught_nail") or not Game:getFlag("taught_healing") then
        if not Game:getFlag("taught_nail") then
            Game:setFlag("taught_nail", true)
            Game.battle:infoText("* Press "..Input.getText("confirm").." to use your NAIL\nagainst orange enemies!")
        else
            Game:setFlag("taught_healing", true)
            Game.battle:infoText("* Press "..Input.getText("cancel").." while at 16% TP to heal!")
        end
        return {"p1/vengeflyking/vengeflies_tutorial"}
    elseif not Game.battle.encounter.seen_charge then
        Game.battle.encounter.seen_charge = true
        return {"p1/vengeflyking/charge"}
    end
    return super:getNextWaves(self)
end

function VengeflyKing:onNailHurt(amount, battler)
    if Game.battle.waves[1].id == "p1/vengeflyking/charge" then
        self.hurt_timer = 0.5
        self.sprite.shake_x = 5
        self.health = self.health - amount
    else
        super:onNailHurt(self, amount, battler)
    end
end

return VengeflyKing