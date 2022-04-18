local Tamer, super = Class("boss")

function Tamer:init()
    super:init(self)
    
    self.name = "God Tamer"
    self:setActor("p3/godtamer")

    self.max_health = 350
    self.health = 350

    self.proj_hb = Hitbox(self, 10,16, 14,32)

    self.waves = {}

    self.text = {
        "* God Tamer poses for the audience.",
        "* God Tamer boasts about how strong\nshe is."
    }
end

return Tamer