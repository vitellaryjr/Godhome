local Galien, super = Class("floatyBoss")

function Galien:init()
    super:init(self)
    
    self.name = "Galien"
    self:setActor("p3/galien")

    self.max_health = 500
    self.health = 500

    self.text = {
        "* A gentle heartbeat pulses above you.",
        "* Small spiders crawl under your feet.",
        "* It feels like an earthquake.",
    }
end

function Galien:getNextWaves()
    if self.health / self.max_health < 0.33 then
        return {"p3/galien/scythe3"}
    elseif self.health / self.max_health < 0.66 then
        return {"p3/galien/scythe2"}
    else
        return {"p3/galien/scythe1"}
    end
end

return Galien