local Voidheart, super = Class(Item)

function Voidheart:init()
    super:init(self)
    
    self.name = "Void Heart"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.description = "Unifies the void under the bearer's will.\nCannot be removed."
end

return Voidheart