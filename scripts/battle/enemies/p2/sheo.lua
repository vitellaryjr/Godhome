local Sheo, super = Class("boss")

function Sheo:init()
    super:init(self)
    
    self.name = "Sheo"
    self:setActor("p2/sheo")

    self.max_health = 900
    self.health = 900

    self.waves = {
        "p2/sheo/greatslash",
        "p2/sheo/stab",
        "p2/sheo/arcs",
        "p2/sheo/movement",
    }

    self.text = {
        "* Sheo paints a picture of you, as a\nsymbol of respect.",
        "* Sheo is disappointed that he has to\nfight you.",
        "* The floor is covered in wet paint.",
        "* Godseeker strikes a pose for Sheo\nto paint.",
    }
end

function Sheo:onDefeat(...)
    super:onDefeat(self, ...)
    Game.battle.encounter:stopMusic()
end

return Sheo