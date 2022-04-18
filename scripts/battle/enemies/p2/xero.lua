local Xero, super = Class("floatyBoss")

function Xero:init()
    super:init(self)

    self.name = "Xero"
    self:setActor("p2/xero")

    self.max_health = 450
    self.health = 450

    self.waves = {}

    self.text = {
        "* Cursed are those who turn against\nthe King.",
        "* Fallen spirits linger in the air.",
        "* Xero rests for a moment.",
    }
end

function Xero:getNextWaves()
    if self.health / self.max_health > 0.5 then
        return {"p2/xero/2swords"}
    else
        return {"p2/xero/4swords"}
    end
end

return Xero