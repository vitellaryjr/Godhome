local Markoth, super = Class("nailbase")

function Markoth:init(x, y)
    super:init(self, x, y, "battle/p4/markoth/markoth")
    self.sprite:play(0.2, true)
    self:setHitbox(1,11,14,20)

    self.enemy = Game.battle:getEnemyByID("p4/markoth")
    self.knockback = 4

    self.ox = x
    self.oy = y
    self.sine = 0
end

function Markoth:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.wave.timer:every(2, function()
        local x, y = love.math.random(arena.left + 20, arena.right - 20), love.math.random(arena.top + 20, arena.bottom - 20)
        self.wave.timer:tween(1.5, self, {ox = x, oy = y}, "in-out-sine")
    end)
end

function Markoth:update(dt)
    super:update(self, dt)
    if self.curr_knockback > 0 then
        self.ox = self.ox + self.curr_knockback*math.cos(self.knockback_dir)*DTMULT
        self.oy = self.oy + self.curr_knockback*math.sin(self.knockback_dir)*DTMULT
    end
    self.sine = self.sine + dt
    self:setPosition(
        self.ox + 6*math.sin(self.sine*3),
        self.oy + 6*math.sin(self.sine*2)
    )
end

return Markoth