local Mawlek, super = Class("boss")

function Mawlek:init()
    super:init(self)

    self.name = "Brooding Mawlek"
    self:setActor("p1/broodingmawlek")

    self.max_health = 700
    self.health = 700

    self.waves = {
        "p1/broodingmawlek/blobGroups",
        "p1/broodingmawlek/blobs",
    }
    
    self.text = {
        "* Brooding Mawlek feels a bit\nlonely.",
        "* Brooding Mawlek lets out a cry."
    }
end

return Mawlek