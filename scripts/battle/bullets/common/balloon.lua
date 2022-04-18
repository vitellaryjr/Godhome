local Balloon, super = Class("nailbase")

function Balloon:init(x, y)
    super:init(self, x, y, "battle/p4/lostkin/balloon")
    self.sprite:play(0.2, true)
    self.collider = CircleCollider(self, 9.5, 8.5, 4)

    self.health = 10

    local soul = Game.battle.soul
    if soul.x < x then
        self.scale_x = -2
    end
    self.physics = {
        speed = 0,
        direction = Utils.angle(x, y, soul.x, soul.y)
    }
end

function Balloon:update(dt)
    super:update(self, dt)
    self.physics.speed = Utils.approach(self.physics.speed, 2, 0.05*DTMULT)
    local soul = Game.battle.soul
    local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.direction = Utils.approachAngle(self.physics.direction, angle_to, 0.15*DTMULT)

    if soul.x < self.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end
end

return Balloon