local Zotefly, super = Class("nailbase")

function Zotefly:init(x, y)
    super:init(self, x, y, "battle/p3/greyprince/zotefly")
    self.sprite:play(0.2, true)

    self.health = 30
    self.knockback = 8

    local soul = Game.battle.soul
    if soul.x < x then
        self.scale_x = 2
    end
    self.physics = {
        speed = 0,
        direction = Utils.angle(x, y, soul.x, soul.y)
    }
end

function Zotefly:update(dt)
    super:update(self, dt)
    self.physics.speed = Utils.approach(self.physics.speed, 3, 0.1*DTMULT)
    local soul = Game.battle.soul
    local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.direction = Utils.approachAngle(self.physics.direction, angle_to, 0.1*DTMULT)

    if soul.x < self.x then
        self.scale_x = 2
    else
        self.scale_x = -2
    end
end

function Zotefly:hit(source, damage)
    super:hit(self, source, damage)
    self.physics.speed = self.physics.speed / 3
end

function Zotefly:onDefeat()
    Utils.removeFromTable(self.wave.enemies, self)
    if #self.wave.enemies == 0 then
        Game.battle.timer:after(0.5, function()
            self.wave.finished = true
        end)
    end
    super:onDefeat(self)
end

return Zotefly