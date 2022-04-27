local Attachment, super = Class(Object)

function Attachment:init()
    super:init(self, 0, 480, 640, 0)
    self.layer = BATTLE_LAYERS["above_ui"]
    self.ui_y = 480
    self.actbar_y = 480
end

function Attachment:update()
    super:update(self)
    if Game.battle.battle_ui then
        self.ui_y = Game.battle.battle_ui.y
        local actbox = Game.battle.battle_ui.action_boxes[1]
        self.actbar_y = actbox.y
    end
end

return Attachment