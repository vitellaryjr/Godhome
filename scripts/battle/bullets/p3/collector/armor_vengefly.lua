local Vengefly, super = Class("nailbase")

function Vengefly:init(x, y, enemy)
    super:init(self, x, y, "battle/p3/collector/armor_vengefly")
    self.sprite:play(0.2, true)

    if enemy then
        self.enemy = enemy
    else
        self.health = 100
    end
    self.knockback = 6

    local soul = Game.battle.soul
    if soul.x > x then
        self.scale_x = -2
    end
    self.physics = {
        speed = 0,
        direction = Utils.angle(x, y, soul.x, soul.y)
    }

    self.type = "armor_vengefly"
end

function Vengefly:update()
    super:update(self)
    self.physics.speed = Utils.approach(self.physics.speed, 4, 0.1*DTMULT)
    local soul = Game.battle.soul
    local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.direction = Utils.approachAngle(self.physics.direction, angle_to, 0.15*DTMULT)

    if soul.x < self.x then
        self.scale_x = 2
    else
        self.scale_x = -2
    end
end

function Vengefly:hit(source, damage)
    super:hit(self, source, damage)
    self.physics.speed = self.physics.speed / 3
end

function Vengefly:onDefeat()
    Utils.removeFromTable(self.wave.jar_enemies, self)
    if self.enemy then
        self.enemy:onDefeat()
    end
    super:onDefeat(self)
end

return Vengefly