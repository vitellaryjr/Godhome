local Mouth, super = Class("nailbase")

function Mouth:init(x, y)
    super:init(self, x, y, "battle/p1/broodingmawlek/mouth")
    self:setHitbox(2,9,20,5)
    self:setOrigin(0.5, 1)
    self.sprite:play(0.2, true)

    self.layer = BATTLE_LAYERS["arena"]+1

    self.enemy = Game.battle:getEnemyBattler("p1/broodingmawlek")
end

return Mouth