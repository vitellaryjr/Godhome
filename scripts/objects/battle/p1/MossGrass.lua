local MossGrass, super = Class("battle/UIAttachment")

function MossGrass:init()
    super:init(self, 0, 0, 640, 540)
    local g1 = Sprite("battle/p1/mosscharger/bg_grass_a", 52,0)
    g1:setOrigin(0.5, 1)
    g1:setScale(2)
    self:addChild(g1)
    local g2 = Sprite("battle/p1/mosscharger/bg_grass_b", self.width-50,0)
    g2:setOrigin(0.5, 1)
    g2:setScale(2)
    self:addChild(g2)
end

return MossGrass