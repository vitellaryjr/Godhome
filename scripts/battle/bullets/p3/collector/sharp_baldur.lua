local Baldur, super = Class("nailbase")

function Baldur:init(x, y, enemy)
    super:init(self, x, y, "battle/p3/collector/sharp_baldur")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)

    if enemy then
        self.enemy = enemy
    else
        self.health = 75
    end
    self.knockback = 4

    self.type = "sharp_baldur"
    self.charging = false
end

function Baldur:onAdd(parent)
    super:onAdd(self, parent)
    local soul = Game.battle.soul
    self.wave.timer:script(function(wait)
        wait(Utils.random(0.2, 0.5))
        while true do
            local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
            self.physics = {
                speed = 4,
                friction = 1,
                direction = angle + math.pi,
            }
            self.graphics.spin = 0.2 * Utils.sign(self.x - soul.x)
            wait(0.5)
            self.charging = true
            self.physics = {
                speed = 6,
                direction = angle,
            }
            self.graphics.spin = -0.3 * Utils.sign(self.x - soul.x)
            wait(Utils.random(1.5,2))
            self.charging = false
            self.physics.friction = 1
            wait(1.5)
        end
    end)
end

function Baldur:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    if self.charging then
        local collided = false
        for _,line in ipairs(arena.collider.colliders) do
            if self:collidesWith(line) then
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, line.x-line.x2,line.y-line.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:setPosition(
                    Utils.clamp(self.x, arena.left+self.collider.radius*2+1, arena.right-self.collider.radius*2-1),
                    Utils.clamp(self.y, arena.top+self.collider.radius*2+1, arena.bottom-self.collider.radius*2-1)
                )
                collided = true
            end
        end
        if collided then
            self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
        end
    else
        self.graphics.spin = Utils.approach(self.graphics.spin, 0, 0.015*DTMULT)
        self:setPosition(
            Utils.clamp(self.x, arena.left+self.collider.radius*2+1, arena.right-self.collider.radius*2-1),
            Utils.clamp(self.y, arena.top+self.collider.radius*2+1, arena.bottom-self.collider.radius*2-1)
        )
    end
end

function Baldur:hit(source, damage)
    super:hit(self, source, damage)
    self.physics.direction = Utils.angle(source.x, source.y, self.x, self.y)
end

function Baldur:onDefeat()
    Utils.removeFromTable(self.wave.jar_enemies, self)
    if self.enemy then
        self.enemy:onDefeat()
    end
    super:onDefeat(self)
end

return Baldur