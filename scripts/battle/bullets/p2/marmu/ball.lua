local Ball, super = Class("nailbase")

function Ball:init(x, y)
    super:init(self, x, y, "battle/p2/marmu/ballin")
    self.collider = CircleCollider(self, self.width/2 + 1, self.height/2, 12)
    self.enemy = Game.battle:getEnemyByID("p2/marmu")

    self.sprite:setRotationOrigin(0.5, 0.5)

    self.chasing = false
end

function Ball:update()
    super:update(self)
    local soul = Game.battle.soul
    if self.charging then
        self.physics.speed = Utils.approach(self.physics.speed, 7.5, 0.5*DTMULT)
        self.physics.gravity_direction = Utils.angle(self.x, self.y, soul.x, soul.y)

        if soul.x < self.x then
            self.sprite.graphics.spin = Utils.approach(self.sprite.graphics.spin, -0.5, 0.05*DTMULT)
        else
            self.sprite.graphics.spin = Utils.approach(self.sprite.graphics.spin, 0.5, 0.05*DTMULT)
        end

        local arena = Game.battle.arena
        local collided = false
        for _,line in ipairs(arena.collider.colliders) do
            if self:collidesWith(line) then
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), self.physics.speed*DTMULT)
                collided = true
            end
        end
        if collided then
            self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
        end
    else
        if soul.x < self.x then
            self.sprite.graphics.spin = Utils.approach(self.sprite.graphics.spin, -0.1, 0.01*DTMULT)
        else
            self.sprite.graphics.spin = Utils.approach(self.sprite.graphics.spin, 0.1, 0.01*DTMULT)
        end
    end
end

function Ball:hit(source, damage)
    super:hit(self, source, damage)
    if self.charging then
        self.physics.speed = 9
        self.physics.direction = Utils.angle(source, self)
    end
end

function Ball:charge()
    local soul = Game.battle.soul
    local soul_angle = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics = {
        speed = 2,
        direction = soul_angle + Utils.random(-math.pi/4, math.pi/4),
        gravity = 0.45,
        gravity_direction = soul_angle,
    }
    self.charging = true
end

function Ball:onDefeat()
    super:onDefeat(self)
    self.wave.finished = true
end

return Ball