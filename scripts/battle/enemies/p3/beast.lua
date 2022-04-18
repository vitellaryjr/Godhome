local Beast, super = Class("boss")

function Beast:init()
    super:init(self)
    
    self.name = "Beast"
    self:setActor("p3/beast")

    self.max_health = 700
    self.health = 700

    self.proj_hb = Hitbox(self, 8,16, 60,46)

    self.waves = {
        "p3/godtamer/ball",
        "p3/godtamer/blades",
        "p3/godtamer/garpedes",
    }

    self.text = {
        "* The audience holds their breath\nin suspense.",
        "* The Lord of Fools approves of this.",
        "* The beast hisses at you.",
    }
end

return Beast