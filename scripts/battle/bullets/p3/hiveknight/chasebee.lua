local Bee, super = Class(Bullet)

function Bee:init(x, y)
    super:init(self, x, y, "battle/p3/hiveknight/chase_bee")
    self.sprite:play(0.2, true)
    self.collider = CircleCollider(self, 14, 10, 4)

    self.rotation = Utils.random(math.pi/3, math.pi*2/3)
    self.physics = {
        speed = 8,
        match_rotation = true,
    }
end

function Bee:update()
    super:update(self)
    local soul = Game.battle.soul
    if self.y < soul.y then
        local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
        if soul.x < self.x then
            angle_to = math.min(angle_to, math.pi*3/4)
        else
            angle_to = math.max(angle_to, math.pi*1/4)
        end
        self.rotation = Utils.approach(self.rotation, angle_to, 0.02*DTMULT)
    end
end

return Bee