local Door, super = Class(Interactable)

function Door:init(data)
    super:init(self, data.x, data.y, data.width, data.height)

    self.cutscene = "enter_pantheon"
    self:setSprite("tilesets/doors/door")
    self.mask_sprite = Sprite("tilesets/doors/door_mask")
    self.mask_sprite.layer = -1
    self.mask_sprite:setScale(2)
    self:addChild(self.mask_sprite)

    self.pantheon = data.properties.pantheon
    self:addChild(PantheonGem(self.pantheon, 40, 0, {
        {-24,8},
        {-14,0},
        {14,0},
        {24,8},
    }))

    self.solid = true
end

return Door