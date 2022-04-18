local Hornet, super = Class("boss")

function Hornet:init()
    super:init(self)

    self.name = "Hornet"
    self:setActor("p1/hornet")

    self.max_health = 600
    self.health = 600

    self.waves = {
        "p1/hornet/silkcircles",
        "p1/hornet/needlechase",
        "p1/hornet/needleretract",
    }
    
    self.text = {
        "* Silk flies through the air.",
        "* Hornet taps her needle on the\nground.",
        "* She's testing you.",
    }
end

function Hornet:onDefeat(...)
    super:onDefeat(self, ...)
    Game.battle.encounter:stopMusic()
end

return Hornet