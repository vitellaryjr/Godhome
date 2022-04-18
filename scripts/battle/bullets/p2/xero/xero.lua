local Xero, super = Class("nailbase")

function Xero:init(x, y)
    super:init(self, x, y, "battle/p2/xero/idle")
    self.sprite:play(0.4, true)
    self:setHitbox(12,5,4,22)

    self.enemy = Game.battle:getEnemyByID("p2/xero")
    self.knockback = 3

    self.sine = 0
    self.mult = 1
    self.slowdown = false
    self.sx = x
end

function Xero:update(dt)
    super:update(self, dt)
    if self.curr_knockback > 0 then
        self.sx = self.sx + self.curr_knockback*math.cos(self.knockback_dir)*DTMULT
    end
    self.mult = Utils.approach(self.mult, self.slowdown and 0 or 1, 0.07*DTMULT)
    self.sine = self.sine + 0.05*self.mult*DTMULT
    self.x = self.sx + 80*math.sin(self.sine)
end

function Xero:onDefeat()
    super:onDefeat(self)
    self.wave.finished = true
end

return Xero