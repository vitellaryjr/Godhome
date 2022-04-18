local Fury, super = Class(Item)

function Fury:init()
    super:init(self)
    
    self.name = "Fallen Fury"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.description = "When close to death, the bearer's strength will\nincrease."
end

return Fury