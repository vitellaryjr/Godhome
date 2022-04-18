local Zoteling, super = Class("ordeal/zotebase")

function Zoteling:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom, "battle/ordeal/zoteling")
    self.sprite:play(0.2, true)
    self:setOrigin(0.5, 1)
    self:setHitbox(3,12, 14,7)
    self.health = 57

    self.rolling = false
end

function Zoteling:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    if self.x < arena.left or self.x > arena.right then
        self.physics.speed_x = self.physics.speed_x*-1
        self:move(self.physics.speed_x, 0, DTMULT)
        if not self.rolling then
            self.physics.speed_x = self.physics.speed_x*0.75
            self.physics.speed_y = -4
            self.physics.gravity = 0.5
            self.physics.gravity_direction = math.pi/2
        end
    end
    if self.rolling then
        if self:collidesWith(arena.collider.colliders[3]) then
            self:shiftOrigin(0.5, 1)
            self:setSprite("battle/ordeal/zoteling", 0.2, true)
            self:setHitbox(1,12, 16,7)
            self.physics = {speed_x = 0}
            self.graphics = {}
            self.rotation = 0
            self.y = arena.bottom
            self.rolling = false
        end
    else
        local soul = Game.battle.soul
        local speed = Utils.clampMap(self.wave.kill_count, 0,50, 5,8)
        if soul.x < self.x then
            self.physics.speed_x = Utils.approach(self.physics.speed_x, -speed, 0.2*DTMULT)
        else
            self.physics.speed_x = Utils.approach(self.physics.speed_x, speed, 0.2*DTMULT)
        end
        if Utils.sign(self.physics.speed_x) == 1 then
            self.scale_x = 2
        else
            self.scale_x = -2
        end
        if self.physics.speed_y and self.physics.speed_y ~= 0 and self.y > arena.bottom then
            self.y = arena.bottom
            local sx = self.physics.speed_x
            self.physics = {speed_x = sx}
        end
    end
    self.x = Utils.clamp(self.x, arena.left, arena.right)
end

function Zoteling:hit(source, damage)
    super:hit(self, source, damage)
    local angle = Utils.angle(source, self)
    if not self.rolling then
        self.physics = {
            speed_x = math.cos(angle)*6,
            speed_y = -math.abs(math.cos(angle)*6) - 2,
            gravity = 0.4,
            gravity_direction = math.pi/2,
        }
        self:shiftOrigin(0.5, 0.5)
        self:setSprite("battle/ordeal/zoteling_roll")
        self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
        self.graphics.spin = 0.5
        self.rolling = true
    else
        self.physics = {
            speed_x = math.cos(angle)*8,
            speed_y = math.sin(angle)*8,
            gravity = 0.4,
            gravity_direction = math.pi/2,
        }
    end
end

return Zoteling