local Fluke, super = Class("ordeal/zotebase")

function Fluke:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom + 40, "battle/ordeal/fluke")
    self.sprite:play(0.2, true)
    self:setHitbox(8,12, 14,20)
    self.health = 60
    self.physics = {
        speed_y = -1.5,
    }

    self.ox = x
    self.sine = Utils.random(math.pi*2)

    local timer = Timer()
    self:addChild(timer)
    timer:after(2, function()
        self:setParent(Game.battle)
    end)
    timer:every(1, function()
        if self.y > arena.bottom then return end
        local blob = self.wave:spawnBullet("common/infection", self.x, self.y)
        blob.layer = self.layer - 1
        blob.physics = {
            speed_y = 2,
            gravity = 0.5,
            gravity_direction = math.pi/2,
        }
    end)
end

function Fluke:update(dt)
    super:update(self, dt)
    self.sine = self.sine + dt
    self.x = self.ox + math.sin(self.sine*5)*10
    if self.y < -30 then
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        self:remove()
    end
end

return Fluke