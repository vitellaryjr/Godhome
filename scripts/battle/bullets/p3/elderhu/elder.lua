local Elder, super = Class("nailbase")

function Elder:init(x, y)
    super:init(self, x, y, "battle/p3/elderhu/elder")
    self.sprite:play(0.4, true)
    self:setHitbox(11,4,8,18)

    self.enemy = Game.battle:getEnemyBattler("p3/elderhu")
    self.knockback = 4

    self.sine = 0
    self.mult = 1
    self.slowdown = false
    self.sx = x
end

function Elder:update()
    super:update(self)
    if self.curr_knockback > 0 then
        self.sx = self.sx + self.curr_knockback*math.cos(self.knockback_dir)*DTMULT
    end
    self.mult = Utils.approach(self.mult, self.slowdown and 0 or 1, 0.07*DTMULT)
    self.sine = self.sine + 0.05*self.mult*DTMULT
    self.x = self.sx + 80*math.sin(self.sine)
end

function Elder:onDefeat()
    super:onDefeat(self)
    self.wave.finished = true
end

return Elder