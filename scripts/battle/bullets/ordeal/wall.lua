local Wall, super = Class("ordeal/zotebase")

function Wall:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.top, "battle/ordeal/wall")
    self.sprite:play(0.2, true)
    self:setOrigin(0.5, 0)
    self:setHitbox(9,0, 4,90)
    self.health = 75
    self.knockback = 9
    self.knockback_recover = 0.3

    self.oob = true
end

function Wall:update()
    super:update(self)
    local arena, soul = Game.battle.arena, Game.battle.soul
    if soul.x < self.x then
        self.physics.speed_x = Utils.approach(self.physics.speed_x, -4, 0.2*DTMULT)
    else
        self.physics.speed_x = Utils.approach(self.physics.speed_x, 4, 0.2*DTMULT)
    end
    if self.oob then
        self.oob = self.x < arena.left or self.x > arena.right
    else
        if self.x < arena.left or self.x > arena.right then
            self.physics.speed_x = self.physics.speed_x*-1
            self:move(self.physics.speed_x, 0, DTMULT)
        end
    end
    if Utils.sign(self.physics.speed_x) == 1 then
        self.scale_x = 2
    else
        self.scale_x = -2
    end
    self.x = Utils.clamp(self.x, arena.left, arena.right)
end

function Wall:getKnockbackDir(source)
    if source.x < self.x then
        return 0
    else
        return math.pi
    end
end

return Wall