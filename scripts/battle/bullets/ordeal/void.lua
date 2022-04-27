local Void, super = Class("ordeal/zotebase")

function Void:init(x, y)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom, "battle/ordeal/void_teleport")
    self.collidable = false
    self.health = 60
    self.knockback = 4
    self.nail_tp = 0
    self.double_damage = true

    self.teleporting = true
    self.sprite:setRotationOrigin(0.5, 0.5)
    self.graphics.spin = 0.2
    Game.battle.timer:tween(0.5, self, {y = y}, "out-quad", function()
        self:setSprite("battle/ordeal/void", 0.2, true)
        self:setHitbox(3,6, 5,16)
        self.collidable = true
        self.teleporting = false
        self.graphics.spin = 0
        self.rotation = 0
        self:setParent(Game.battle)
        local soul = Game.battle.soul
        self.physics = {
            speed = 0,
            direction = Utils.angle(self, soul),
        }
    end)
end

function Void:update()
    super:update(self)
    if self.teleporting then return end
    self.physics.speed = Utils.approach(self.physics.speed, 1.5, 0.05*DTMULT)
    local soul = Game.battle.soul
    local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.direction = Utils.approachAngle(self.physics.direction, angle_to, 0.2*DTMULT)

    if soul.x < self.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end
end

function Void:hit(source, damage)
    self.physics.speed = self.physics.speed / 3
    super:hit(self, source, damage)
end

function Void:killAnim()
    self:setSprite("battle/ordeal/void_teleport")
    self.collidable = false
    self.teleporting = true
    self.physics = {}
    self.graphics.spin = 0.2
    self.wave.timer:after(0.5, function()
        local arena = Game.battle.arena
        self.wave.timer:tween(0.5, self, {y = arena.bottom + 12}, "in-quad", function()
            self:remove()
        end)
    end)
end

return Void