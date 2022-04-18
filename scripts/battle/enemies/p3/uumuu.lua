local Uumuu, super = Class("boss")

function Uumuu:init()
    super:init(self)
    
    self.name = "Uumuu"
    self:setActor("p3/uumuu")

    self.max_health = 960
    self.health = 960
    self.defense = 999

    self.waves = {
        "p3/uumuu/chase",
        "p3/uumuu/patterns",
    }

    self.text = {
        "* Uumuu wriggles around.",
        "* The infection inside Uumuu pulses.",
        "* Quirrel can't help you now.",
    }

    self.proj_hb = CircleCollider(self, 25, 25, 25)
end

function Uumuu:getNextWaves()
    if self.seen_waves["p3/uumuu/chase"] and self.seen_waves["p3/uumuu/patterns"] then
        self.waves = {
            "p3/uumuu/chase_ooma",
            "p3/uumuu/patterns_ooma",
        }
        self.seen_waves = {}
        return super:getNextWaves(self)
    end
    return super:getNextWaves(self)
end

return Uumuu