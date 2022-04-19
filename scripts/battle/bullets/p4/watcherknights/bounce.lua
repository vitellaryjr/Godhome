local Bounce, super = Class("nailbase")

function Bounce:init(x, y, enemy)
    super:init(self, x, y, "battle/p4/watcherknights/bullet")
    self.sprite:stop()
    self.collider = CircleCollider(self, 20, 20, 12)
    self.wall_collider = CircleCollider(self, 20, 20, 15)
    self.enemy = enemy

    self:setScale(1.6)

    self.vulnerable = true
    self.bouncing = false
end

function Bounce:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        while true do
            wait(Utils.random(0.5,1))
            self:startAttack()
            while not self.bouncing do
                wait()
            end
            while self.bouncing do
                wait()
            end
            wait(0.2)
        end
    end)
end

function Bounce:update(dt)
    super:update(self, dt)
    if self.bouncing then
        local arena = Game.battle.arena
        if self.wall_collider:collidesWith(arena.collider.colliders[2]) or self.wall_collider:collidesWith(arena.collider.colliders[4]) then
            self.physics.speed_x = self.physics.speed_x * -1
            self:move(self.physics.speed_x*DTMULT, 0)
        end
    end
end

function Bounce:startAttack()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.wave.timer:script(function(wait)
        self.physics = {
            speed_y = -4,
            gravity = 0.7,
            gravity_direction = math.pi/2,
        }
        local spin
        if soul.x < self.x then
            spin = -0.5
        else
            spin = 0.5
        end
        self.wave.timer:tween(0.2, self.graphics, {spin = spin})
        while not Game.battle:checkSolidCollision(self.wall_collider) do
            wait()
        end
        self.physics = {
            speed_x = Utils.sign(soul.x - self.x)*Utils.random(4,6),
            speed_y = -11,
            gravity = 0.5,
            gravity_direction = math.pi/2,
        }
        self.y = arena.bottom - 26
        self.vulnerable = false
        self.color = {1,1,1}
        local mask = ColorMaskFX({1,1,1}, 1)
        self:addFX(mask)
        self.wave.timer:tween(0.3, mask, {amount = 0}, "linear", function()
            self:removeFX(mask)
        end)
        self.bouncing = true
        for i=1,2 do
            while not self.wall_collider:collidesWith(arena.collider.colliders[3]) do
                wait()
            end
            self.physics.speed_y = self.physics.speed_y * -0.7
            self:move(0, self.physics.speed_y*1.5*DTMULT)
        end
        self.physics = {
            speed_y = -4,
            gravity = 0.7,
            gravity_direction = math.pi/2,
        }
        self.wave.timer:tween(0.2, self.graphics, {spin = 0})
        self.vulnerable = true
        self.color = {1, 0.8, 0.5}
        local mask = ColorMaskFX({1,0.8,0.5}, 1)
        self:addFX(mask)
        self.wave.timer:tween(0.3, mask, {amount = 0}, "linear", function()
            self:removeFX(mask)
        end)
        self.bouncing = false
        while not Game.battle:checkSolidCollision(self.wall_collider) do
            wait()
        end
        self.physics = {}
        self.y = arena.bottom - 26
    end)
end

function Bounce:hit(source, damage)
    if self.vulnerable then
        super:hit(self, source, damage)
    else
        -- special "no damage" animation?
    end
end

return Bounce