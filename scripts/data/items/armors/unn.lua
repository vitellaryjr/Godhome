local Unn, super = Class(Item)

function Unn:init()
    super:init(self)
    
    self.name = "Shape of Unn"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.description = "While focusing TP, the bearer can shift its\nposition slowly."
end

return Unn