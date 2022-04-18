local Elder, super = Class("floatyBoss")

function Elder:init()
    super:init(self)
    
    self.name = "Elder Hu"
    self:setActor("p3/elderhu")

    self.max_health = 550
    self.health = 550

    self.waves = {
        "p3/elderhu/rings",
        "p3/elderhu/pancakes",
    }

    self.text = {
        "* We remember the Elder.",
        "* Mantises laugh in the distance.",
    }
end

return Elder