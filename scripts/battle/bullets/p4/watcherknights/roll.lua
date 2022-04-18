local Roll, super = Class("nailbase")

function Roll:init(x, y, enemy)
    super:init(self, x, y, "battle/p4/watcherknights/bullet")
    self.sprite:stop()
    self.collider = CircleCollider(self, 20, 20, 12)
    self.wall_collider = CircleCollider(self, 20, 20, 12)
    self.enemy = enemy

    self.vulnerable = true
    self.rolling = false
    self.bonks = 0
end

function Roll:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        while true do
            wait(Utils.random(0.5,1))
            self:startAttack()
            while not self.rolling do
                wait()
            end
            while self.rolling do
                wait()
            end
        end
    end)
end

function Roll:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    if self.rolling then
        for _,side in ipairs(arena.collider.colliders) do
            if self.wall_collider:collidesWith(side) then
                self.bonks = self.bonks + 1
                local vx,vy = Vector.fromPolar(self.physics.direction, self.physics.speed)
                local nvx,nvy = Vector.mirror(vx,vy, side.x-side.x2,side.y-side.y2)
                self.physics.direction = Vector.toPolar(nvx,nvy)
                self:move(math.cos(self.physics.direction), math.sin(self.physics.direction), self.physics.speed*DTMULT)
                self.sprite.graphics.spin = math.abs(self.sprite.graphics.spin)*Utils.sign(math.cos(self.physics.direction))
                if self.bonks == 3 then
                    self.bonks = 0
                    self:stopAttack()
                end
            end
        end
    else
        self:setPosition(
            Utils.clamp(self.x, arena.left+self.wall_collider.radius*2+1, arena.right-self.wall_collider.radius*2-1),
            Utils.clamp(self.y, arena.top+self.wall_collider.radius*2+1, arena.bottom-self.wall_collider.radius*2-1)
        )
    end
end

function Roll:hit(source, damage)
    if self.vulnerable then
        super:hit(self, source, damage)
    else
        -- special "no damage" animation?
    end
end

function Roll:startAttack()
    local soul = Game.battle.soul
    local angle = Utils.angle(self, soul)
    self.physics = {
        speed = 6,
        direction = angle + math.pi,
    }
    local spin
    if soul.x < self.x then
        spin = -0.5
    else
        spin = 0.5
    end
    self.wave.timer:tween(0.2, self.graphics, {spin = spin})
    self.sprite:play(0.1, true)
    self.wave.timer:after(0.4, function()
        self.physics = {
            speed = 12,
            direction = angle,
        }
        self.vulnerable = false
        self.color = {1,1,1}
        local mask = ColorMaskFX({1,1,1}, 1)
        self:addFX(mask)
        self.wave.timer:tween(0.3, mask, {amount = 0}, "linear", function()
            self:removeFX(mask)
        end)
        self.rolling = true
    end)
end

function Roll:stopAttack()
    self.vulnerable = true
    self.color = {1, 0.8, 0.5}
    local mask = ColorMaskFX({1,0.8,0.5}, 1)
    self:addFX(mask)
    self.wave.timer:tween(0.3, mask, {amount = 0}, "linear", function()
        self:removeFX(mask)
    end)
    self.sprite:stop()
    self.wave.timer:tween(0.2, self.graphics, {spin = 0})
    self.wave.timer:tween(0.5, self.physics, {speed = 0}, "linear", function()
        self.rolling = false
    end)
end

return Roll