local Attachment, super = Class(Object)

function Attachment:init(height)
    super:init(self, 0, 480+height, 640, height)
    self.layer = BATTLE_LAYERS["bottom"]+100
end

function Attachment:update()
    super:update(self)
    if Game.battle.battle_ui then
        self.y = Utils.clampMap(Game.battle.battle_ui.y, 325,480, 325,480+self.height)
    end
end

return Attachment