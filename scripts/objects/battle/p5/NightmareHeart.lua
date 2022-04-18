local Heart, super = Class(Sprite)

function Heart:init()
    super:init(self, "battle/p5/nkg/bg_heart", 320, 0)
    self.layer = BATTLE_LAYERS["bottom"] + 10
    self:setOrigin(0.5, 0)
    self.alpha = 0.4
end

function Heart:beat()
    self:setScale(1.05)
    Game.battle.timer:tween(0.2, self, {scale_x = 1, scale_y = 1})
end

return Heart