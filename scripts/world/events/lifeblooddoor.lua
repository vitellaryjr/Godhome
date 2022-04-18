local Door, super = Class(Event)

function Door:init(data)
    super:init(self, data)
    self.sprite = Sprite("tilesets/doors/lifeblood_door", data.width/2, data.height)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.solid = true
end

return Door