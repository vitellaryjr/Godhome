local Statue, super = Class(Interactable)

function Statue:init(data)
    super:init(self, data.x, data.y, data.width, data.height)
    local highest_clear = Mod:getBossClears()
    local knight = Game:getPartyMember("knight")
    local text
    if highest_clear == "attuned" then
        text = "* Not bug, nor beast, nor god."
        knight.level = 2
        knight.title = "Not bug, nor beast,\nnor god."
    elseif highest_clear == "ascended" then
        text = "* Void given form."
        knight.level = 3
        knight.title = "Void given form."
    elseif highest_clear == "radiant" then
        text = "* Void given focus."
        knight.level = 4
        knight.title = "Void given focus."
    end
    self.text = {text}

    self.sprite = Sprite("tilesets/statues/knight_"..highest_clear, data.width/2, data.height)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    if highest_clear ~= "none" then
        self.text_sprite = Sprite("tilesets/statues/difficulty_text", data.width/2, data.height - 10)
        self.text_sprite:setOrigin(0.5, 1)
        self.text_sprite:setScale(2)
        self:addChild(self.text_sprite)
    end
end

return Statue