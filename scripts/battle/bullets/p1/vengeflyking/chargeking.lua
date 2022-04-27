local Charge, super = Class("nailbase")

function Charge:init(enemy)
    super:init(self, 0, 0, "battle/p1/vengeflyking/charge")
    self.sprite:stop()
    self:setOrigin(0, 0)
    self:setScale(1, 1)

    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.2,
    }

    self:setHitbox(16,24, 16,12)

    self.enemy = enemy
end

function Charge:update()
    super:update(self)
    self.sprite:setFrame(self.parent.frame)
end

function Charge:onDefeat()
    super:onDefeat(self)
    self.wave.finished = true
end

return Charge