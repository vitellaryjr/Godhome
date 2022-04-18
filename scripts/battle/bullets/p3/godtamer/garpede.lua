local Tail, T_super = Class(Bullet)

function Tail:init(x, y, dir, speed)
    T_super:init(self, x, y, "battle/p3/godtamer/garpede_end")
    self.sprite:play(0.4, true)
    self:setOriginExact(12,8)
    self:setHitbox(8,2,12,12)
    self.rotation = dir
    self.physics = {
        speed = speed,
        match_rotation = true,
    }
    self.tp = 0.4

    self:addChild(NailComponent())
end

local Body, B_super = Class(Bullet)

function Body:init(x, y, dir, speed)
    B_super:init(self, x, y, "battle/p3/godtamer/garpede_body")
    self.sprite:play(0.2, true)
    self:setHitbox(0,2,16,12)
    self.rotation = dir
    self.physics = {
        speed = speed,
        match_rotation = true,
    }
    self.tp = 0.4

    self:addChild(NailComponent())

    self.sine = Utils.random(math.pi*2)
end

function Body:update(dt)
    B_super:update(self, dt)
    self.sine = self.sine + dt
    local dx, dy = math.cos(self.rotation), math.sin(self.rotation)
    local sine = math.sin(self.sine*4)
    self.sprite:setPosition(2*dx*sine, 2*dy*sine)
end

local Head, H_super = Class(Bullet)

function Head:init(x, y, dir, length, speed)
    H_super:init(self, x, y, "battle/p3/godtamer/garpede_head")
    self.sprite:play(0.3, true)
    self:setOriginExact(8,8)
    self:setHitbox(0,2,16,12)
    self.rotation = dir
    self.physics = {
        speed = speed or 6,
        match_rotation = true,
    }

    self:addChild(NailComponent())

    self.length = length
end

function Head:onAdd(parent)
    H_super:onAdd(self, parent)
    local dx, dy = -math.cos(self.rotation), -math.sin(self.rotation)
    local dist = 22
    for i=1,self.length-1 do
        local x, y = self.x + dist*i*dx, self.y + dist*i*dy
        local segment = self.wave:spawnBulletTo(Game.battle.mask, Body(x, y, self.rotation, self.physics.speed))
        segment.layer = self.layer - i
    end
    local x, y = self.x + dist*self.length*dx, self.y + dist*self.length*dy
    local tail = self.wave:spawnBulletTo(Game.battle.mask, Tail(x, y, self.rotation, self.physics.speed))
    tail.layer = self.layer - self.length
end

return Head