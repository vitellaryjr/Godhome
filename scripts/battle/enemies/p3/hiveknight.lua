local HiveKnight, super = Class("boss")

function HiveKnight:init()
    super:init(self)
    
    self.name = "Hive Knight"
    self:setActor("p3/hiveknight")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p3/hiveknight/sword",
        "p3/hiveknight/fallingbees",
        "p3/hiveknight/honeyspikes",
    }

    self.text = {
        "* Hive Knight buzzes quietly.",
        "* The audience is buzzing with\nexcitement."
    }
end

return HiveKnight