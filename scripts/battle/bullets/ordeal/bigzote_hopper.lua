local Hopper, super = Class("nailbase")

function Hopper:init(x, y, sx, bigone)
    super:init(self, x, y, "battle/ordeal/hopper_jump")
    self:setOrigin(0.5, 1)
    self:setHitbox(5,6, 6,11)
    self.health = 30
    self.knockback = 0
    self.physics = {
        speed_y = 2,
        speed_x = sx,
        gravity = 0.3,
        gravity_direction = math.pi/2,
    }

    self.bigzote = bigone
end

function Hopper:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.wave.timer:script(function(wait)
        while true do
            while self.y <= arena.bottom do
                wait()
            end
            self.physics = {}
            self.y = arena.bottom
            self:setSprite("battle/ordeal/hopper_idle", 0.3, true)
            wait(Utils.random(0.5,1.5))
            self.physics = {
                speed_y = -9,
                speed_x = Utils.random(-3,3),
                gravity = 0.3,
                gravity_direction = math.pi/2,
            }
            self:setSprite("battle/ordeal/hopper_jump")
        end
    end)
end

function Hopper:update()
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

function Hopper:hit(source, damage)
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

function Hopper:onDefeat()
    Utils.removeFromTable(self.bigzote.hoppers, self)
    local head = Sprite("battle/ordeal/zote_kill", self.x, self.y)
    head:setLayer(BATTLE_LAYERS["below_bullets"])
    head:setScale(2)
    head:setOrigin(0.5, 0.5)
    head.physics = {
        speed_x = Utils.random(-3,3),
        speed_y = -8,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    head.graphics.spin = Utils.sign(head.physics.speed_x)*0.3
    Game.battle:addChild(head)
    head:fadeOutAndRemove(0.02)
    super:onDefeat(self)
end

return Hopper