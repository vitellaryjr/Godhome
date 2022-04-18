local Dung, super = Class("p1/dungdefender/bounce")

function Dung:init(x, y, dir)
    super:init(self, x, y, dir, "battle/p1/dungdefender/defenderball")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 10)
    self.enemy = Game.battle:getEnemyByID("p1/dungdefender")
end

return Dung