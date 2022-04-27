local ZoteHopper, super = Class("ordeal/zotebase")

function ZoteHopper:init(x)
    super:init(self, x, Game.battle.arena.bottom, "battle/ordeal/hopper_idle")
    self.sprite:play(0.3, true)
    self:setOrigin(0.5, 1)
    self:setHitbox(5,6, 6,11)

    self.health = 45
    self.knockback = 0
end

function ZoteHopper:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.wave.timer:script(function(wait)
        while true do
            wait(Utils.random(0.5,1.5))
            self.physics = {
                speed_y = -9,
                speed_x = Utils.random(-6,6),
                gravity = 0.3,
                gravity_direction = math.pi/2,
            }
            self:setSprite("battle/ordeal/hopper_jump")
            while self.y <= arena.bottom do
                wait()
            end
            self.physics = {}
            self.y = arena.bottom
            self:setSprite("battle/ordeal/hopper_idle", 0.3, true)
        end
    end)
end

function ZoteHopper:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.x < arena.left or self.x > arena.right then
        if self.physics.speed_x then
            self.physics.speed_x = self.physics.speed_x * -1
            self:move(self.physics.speed_x, 0, DTMULT)
        end
        self.x = Utils.clamp(self.x, arena.left, arena.right)
    end
end

function ZoteHopper:hit(source, damage)
    super:hit(self, source, damage)
    if not self.physics.speed_x then return end
    local angle = Utils.angle(source, self)
    if source.y > self.y or math.abs(math.cos(angle)) > math.abs(math.sin(angle)) then
        if Utils.sign(source.x - self.x) == Utils.sign(self.physics.speed_x) then
            self.physics.speed_x = self.physics.speed_x*-1
        end
    elseif source.y < self.y then
        if self.physics.speed_y then
            self.physics.speed_y = math.abs(self.physics.speed_y)
        end
    end
end

return ZoteHopper