local WingedNosk, super = Class("floatyBoss")

function WingedNosk:init()
    super:init(self)
    
    self.name = "Winged Nosk"
    self:setActor("p5/wingednosk")

    self.max_health = 700
    self.health = 700

    self.waves = {
        "p5/wingednosk/blobsA",
        "p5/wingednosk/blobsB",
        "p5/wingednosk/vessels",
    }
    
    self.text = {
        "* Winged Nosk screeches quietly.",
        "* Winged Nosk chews on a corpse.",
        "* Winged Nosk's head slowly rotates.",
        "* She's not here to protect you.",
    }

    self.float_height = 2
    self.float_speed = 0
end

return WingedNosk