local SteadyBody, super = Class(Item)

function SteadyBody:init()
    super:init(self)
    
    self.name = "Steady Body"
    self.type = "armor"
    self.icon = "ui/menu/icon/armor"
    self.description = "Allows one to stay steady and keep attacking."
end

return SteadyBody