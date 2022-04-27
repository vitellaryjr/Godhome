local Heavy, super = Class("ordeal/zotebase")

function Heavy:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom, "battle/ordeal/heavy")
    self.sprite:play(0.3, true)
    self:setOrigin(0.5, 1)
    self.collider = CircleCollider(self, 16,20, 10)
    self.health = 60
end

function Heavy:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        while true do
            wait(Utils.random(1,2))
            self.physics = {
                speed_y = -10,
                speed_x = Utils.random(4,6)*Utils.randomSign(),
                gravity = 0.5,
                gravity_direction = math.pi/2,
            }
            self:setSprite("battle/ordeal/heavy_jump")
            while self.y <= arena.bottom do
                wait()
            end
            self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 60, 60, 6)
            self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 60, 60, -6)
            self.physics = {}
            self.y = arena.bottom
            self:setSprite("battle/ordeal/heavy", 0.3, true)
        end
    end)
end

function Heavy:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.x < arena.left + 20 or self.x > arena.right - 20 then
        if self.physics.speed_x then
            self.physics.speed_x = self.physics.speed_x * -1
            self:move(self.physics.speed_x, 0, DTMULT)
        end
        self.x = Utils.clamp(self.x, arena.left + 20, arena.right - 20)
    end
    if self.physics.speed_x then
        if Utils.sign(self.physics.speed_x) == 1 then
            self.scale_x = 2
        else
            self.scale_x = -2
        end
    end
end

return Heavy