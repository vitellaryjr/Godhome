local Charge, super = Class("nailbase")

function Charge:init(x, y, dir_x, dir_y)
    super:init(self, x, y, "battle/p1/mosscharger/mossy")
    self:setOrigin(0.5, 1)
    self:setScale(dir_x*2, dir_y*2)
    self:setHitbox(17,12,47,30)
    self.sprite:play(0.15, true)
    self.physics.speed_x = dir_x*9

    self.enemy = Game.battle:getEnemyBattler("p1/mosscharger")
    self.knockback = 10
    self.knockback_recover = 0.9
end

function Charge:hit(source, damage)
    super:hit(self, source, damage)
    self.wave.time = self.wave.time + 0.2
end

function Charge:getKnockbackDir(source)
    if source.x > self.x then
        return math.pi
    else
        return 0
    end
end

return Charge