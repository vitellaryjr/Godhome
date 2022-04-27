local Vengefly, super = Class("nailbase")

function Vengefly:init(x, y)
    super:init(self, x, y, "battle/p1/vengeflyking/vengefly")
    self.sprite:play(0.2, true)

    self.health = 30
    self.knockback = 4
    self.nail_tp = 2.5 -- enough that killing 2 gives enough tp for a spell if the player landed a crit

    self.physics = {
        speed = 0.2,
        direction = Utils.random(math.pi*2),
    }

    self.scale_x = -2*Utils.sign(math.cos(self.physics.direction))

    self.started = false
end

function Vengefly:update()
    super:update(self)
    if self.started then
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
end

function Vengefly:hit(source, damage)
    super:hit(self, source, damage)
    if self.started then
        self.physics.speed = self.physics.speed / 3
    else
        self.started = true
    end
end

function Vengefly:onDefeat()
    Utils.removeFromTable(self.wave.vengeflies, self)
    if #self.wave.vengeflies == 0 then
        Game.battle.timer:after(0.5, function()
            self.wave.finished = true
        end)
    end
    super:onDefeat(self)
end

function Vengefly:startle(dir)
    self.physics = {
        speed = 3,
        friction = 0.5,
        direction = dir,
    }
    local soul = Game.battle.soul
    if soul.x < self.x then
        self.scale_x = 2
    else
        self.scale_x = -2
    end
    self.wave.timer:after(0.5, function()
        self.physics.friction = 0
        self.physics.direction = Utils.angle(self, soul)
        self.knockback = 6
        self.started = true
    end)
end

return Vengefly