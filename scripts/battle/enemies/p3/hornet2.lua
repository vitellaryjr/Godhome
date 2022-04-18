local Hornet, super = Class("boss")

function Hornet:init()
    super:init(self)

    self.name = "Hornet"
    self:setActor("p1/hornet")

    self.max_health = 800
    self.health = 800

    self.waves = {
        "p3/hornet2/needlechase",
        "p3/hornet2/needleretract",
        "p3/hornet2/silkcircles",
    }
    
    self.text = {
        "* Silk and ash fly through the air.",
        "* She's seen your likes before, but\nis impressed by your skill so far.",
        "* The wind is roaring past you.",
    }
end

function Hornet:selectWave()
    local result = super:selectWave(self)
    if result == "p3/hornet2/needleretract" then
        Utils.removeFromTable(self.waves, "p3/hornet2/needleretract")
        table.insert(self.waves, "p3/hornet2/needleretract2")
    end
    return result
end

function Hornet:onDefeat(...)
    super:onDefeat(self, ...)
    Game.battle.encounter:stopMusic()
end

return Hornet