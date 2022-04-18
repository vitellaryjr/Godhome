local Angry, super = Class(Wave)

function Angry:init()
    super:init(self)

    self.time = 9
end

function Angry:onStart()
    self.timer:every(0.8, function()
        Game.battle.shake = 2
        Game.battle.encounter:spawnRocks(self, 2 + Game.battle:getEnemyByID("p4/failedchamp").phase)
    end)
end

return Angry