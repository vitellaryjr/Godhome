local DungDefender, super = Class("boss")

function DungDefender:init()
    super:init(self)

    self.name = "Dung Defender"
    self:setActor("p1/dungdefender")

    self.max_health = 650
    self.health = 650

    self.waves = {
        "p1/dungdefender/bounce",
        "p1/dungdefender/arcs",
    }

    self.text = {
        "* Smells.",
        "* The air stings with acidity.",
        "* Isma is sleeping.",
        "* Dripping sounds echo from\neverywhere.",
    }

    self.rushed = false
end

function DungDefender:hurt(amount, battler, on_defeat)
    super:hurt(self, amount, battler, on_defeat)
    if not self.rushed and self.health <= self.max_health/2 then
        Game.battle.encounter.rushing = true
    end
end

function DungDefender:getNextWaves()
    if Game.battle.encounter.rushing then
        self.rushed = true
        Game.battle.encounter.rushing = false
        return {"p1/dungdefender/rapidarcs"}
    end
    return super:getNextWaves(self)
end

return DungDefender