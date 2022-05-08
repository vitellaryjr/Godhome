local Markoth, super = Class("nailbase")

function Markoth:init(x, y)
    super:init(self, x, y, "battle/p4/markoth/markoth")
    self.sprite:play(0.2, true)
    self:setHitbox(1,11,14,20)

    self.enemy = Game.battle:getEnemyBattler("p4/markoth")
    self.knockback = 4

    self.ox = x
    self.oy = y
    self.sine = 0
end

function Markoth:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.wave.timer:every(3, function()
        local rxl, rxr = Utils.clamp(self.ox - 80, arena.left + 20, arena.right - 20), Utils.clamp(self.ox + 80, arena.left + 20, arena.right - 20)
        local ryl, ryr = Utils.clamp(self.oy - 80, arena.top + 20, arena.bottom - 20), Utils.clamp(self.oy + 80, arena.top + 20, arena.bottom - 20)
        local x, y = love.math.random(rxl, rxr), love.math.random(ryl, ryr)
        self.wave.timer:tween(2.5, self, {ox = x, oy = y}, "in-out-back")
    end)
end

function Markoth:update()
    super:update(self)
    if self.curr_knockback > 0 then
        self.ox = self.ox + self.curr_knockback*math.cos(self.knockback_dir)*DTMULT
        self.oy = self.oy + self.curr_knockback*math.sin(self.knockback_dir)*DTMULT
    end
    self.sine = self.sine + DT
    self:setPosition(
        self.ox + 4*math.sin(self.sine*3),
        self.oy + 4*math.sin(self.sine*2)
    )
end

return Markoth