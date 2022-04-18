local Nosk, super = Class("boss")

function Nosk:init()
    super:init(self)
    
    self.name = "Nosk"
    self:setActor("p2/nosk")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p2/nosk/blobsA",
        "p2/nosk/blobsB",
        "p2/nosk/vessels",
    }

    self.text = {
        "* Nosk tries to look into your soul.",
        "* Nosk's head spins.",
        "* Good thing you have a lantern."
    }
end

return Nosk