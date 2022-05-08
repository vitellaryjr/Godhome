local Flukemarm, super = Class("nailbase")

function Flukemarm:init(x, y)
    super:init(self, x, y, "battle/p2/flukemarm/idle")
    self:setHitbox(4,4,20,35)
    self.sprite:play(0.3, true)
    self.enemy = Game.battle:getEnemyBattler("p2/flukemarm")
end

function Flukemarm:onDefeat()
    self.wave.finished = true
    super:onDefeat(self)
end

return Flukemarm