local BGBlob, super = Class(Bullet)

function BGBlob:init(x, y)
    super:init(self, x, y)
    self:setScale(1, 1)

    self.collider = CircleCollider(self, 0,0, 8)
    self.circle_rad = 12

    self.pulse = 0
end

function BGBlob:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:every(0.5, function()
        self.pulse = 4
    end)
end

function BGBlob:update()
    super:update(self)
    if Game.battle.state ~= "DEFENDING" then
        self:remove()
        return
    end
    self.pulse = Utils.approach(self.pulse, 0, 0.8*DTMULT)
    self.circle_rad = 12 + self.pulse
end

function BGBlob:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", 0,0, self.circle_rad)
    super:draw(self)
end

-----

local WallBlob, super = Class(Bullet)

function WallBlob:init(x, y)
    super:init(self, x, y, "battle/misc/shapes/circle")
    self:setScale(1, 1)
    self:setHitbox(2,7,12,2)
    self.sprite:setScale(2,1)
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.pulse = 1
end

function WallBlob:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:every(Utils.random(0.5, 0.7), function()
        self.pulse = 1.3
    end)
end

function WallBlob:update()
    super:update(self)
    if Game.battle.state ~= "DEFENDING" then
        self:remove()
        return
    end
    self.pulse = Utils.approach(self.pulse, 1, 0.1*DTMULT)
    self.sprite:setScale(2*self.pulse, 1*self.pulse)
end

-----

local Blob, super = Class("common/infection")

function Blob:mark(x, y)
    self.ps = ParticleEmitter(x, y, {
        layer = BATTLE_LAYERS["below_soul"],
        shape = "circle",
        color = {1, 0.2, 0},
        alpha = 0.5,
        scale = 0.8,
        scale_var = 0.2,
        angle = {0,math.pi*2},
        speed = 2,
        speed_var = 0.5,
        friction = 0.1,
        shrink = 0.1,
        shrink_after = 0.1,
        every = 0.2,
        amount = {2,4},
    })
    self.wave:addChild(self.ps)
end

function Blob:stickToBG()
    if not self.stage then return end
    local new = BGBlob(self.x, self.y)
    new.tp = self.tp
    self.wave:spawnBullet(new)
    self:remove()
end

function Blob:stickToSide(side)
    if not self.stage then return end
    local arena = Game.battle.arena
    local x, y = self.x, self.y
    local ax, ay, bx, by = side.x, side.y, side.x2, side.y2
    if ax == bx then
        x = ax + arena:getLeft()
    elseif ay == by then
        y = ay + arena:getTop()
    else
        local side_len = Vector.dist(ax,ay, bx,by)
        local point_len = Vector.dist(ax,ay, x,y)
        local t = point_len/side_len
        x = Utils.lerp(ax,bx, t) + arena:getLeft()
        y = Utils.lerp(ay,by, t) + arena:getTop()
    end
    local new = WallBlob(x, y)
    new.tp = self.tp
    self.wave:spawnBulletTo(Game.battle.mask, new)
    new.rotation = Utils.angle(ax,ay, bx,by)
    self:remove()
end

function Blob:onRemove(parent)
    if self.ps then self.ps:remove() end
    super:remove(self, parent)
end

return Blob