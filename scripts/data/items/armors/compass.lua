local Compass, super = Class(Item)

function Compass:init()
    super:init(self)
    
    self.name = "Compass"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.description = "The best charm."
end

return Compass