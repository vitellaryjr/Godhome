local Turret, super = Class("ordeal/zotebase")

function Turret:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.top - 100, "battle/ordeal/turret")
    self:setOrigin(0.5, 0)
    self.collider.collidable = false
    self.nail_hb = Hitbox(self, 0,25, 11,9)
    self.health = 90
end

function Turret:onAdd(parent)
    super:onAdd(self, parent)
    local arena, soul = Game.battle.arena, Game.battle.soul
    local timer = Timer()
    self:addChild(timer)
    timer:tween(0.2, self, {y = arena.top - love.math.random(20)}, "out-quad")
    timer:script(function(wait)
        for _=1,8 do
            wait(2)
            self.shaking = true
            wait(0.5)
            self.shaking = false
            local x, y = self.x, self.y+52
            local bullet = self.wave:spawnBullet("common/infection", x, y)
            bullet.physics = {
                speed = 6,
                direction = Utils.angle(x, y, soul.x, soul.y),
                gravity = 0.05,
                gravity_direction = math.pi/2,
            }
            bullet.layer = self.layer - 1
        end
        wait(4)
        timer:tween(0.2, self, {y = arena.top - 100}, "in-quad")
        wait(0.2)
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        self:remove()
    end)
end

function Turret:update()
    super:update(self)
    if self.shaking then
        self.sprite.x = love.math.random(-1,1)
    else
        self.sprite.x = 0
    end
end

return Turret