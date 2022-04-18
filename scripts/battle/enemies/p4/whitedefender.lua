local WhiteDefender, super = Class("boss")

function WhiteDefender:init()
    super:init(self)

    self.name = "White Defender"
    self:setActor("p4/whitedefender")

    self.max_health = 800
    self.health = 800

    self.waves = {
        "p4/whitedefender/bounce",
        "p4/whitedefender/arcs",
    }

    self.text = {
        "* Smells dignified.",
        "* Dung Defender won't be upset if\nyou win.",
        "* Be glad this isn't the Battle of\nthe Blackwyrm.",
        "* Isma watches with pride.",
    }

    self.rushed = false
end

function WhiteDefender:hurt(amount, battler, on_defeat)
    super:hurt(self, amount, battler, on_defeat)
    if not self.rushed and self.health <= self.max_health/2 then
        Game.battle.encounter.rushing = true
    end
end

function WhiteDefender:getNextWaves()
    if Game.battle.encounter.rushing then
        self.rushed = true
        Game.battle.encounter.rushing = false
        return {"p4/whitedefender/rapidarcs"}
    end
    return super:getNextWaves(self)
end

return WhiteDefender