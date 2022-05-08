local Cyclone, super = Class("nailbase")

function Cyclone:init(x, y)
    super:init(self, x, y, "battle/p1/nailmasters/cycloneslash")
    self.rotation = math.pi/2
    self.sprite:play(0.1, true)
    self:setHitbox(4,6,12,48)
    self.enemy = Game.battle:getEnemyBattler("p3/sly")
end

function Cyclone:update()
    super:update(self)
    local arena = Game.battle.arena
    self.physics.speed_y = Utils.approach(self.physics.speed_y, 8, 0.3*DTMULT)
    if self:collidesWith(arena.collider.colliders[3]) then
        self.physics.speed_y = -8
        self:move(0,-8)
    end
    local soul = Game.battle.soul
    if self.x < soul.x then
        if self.physics.speed_x < 0 then
            self.physics.speed_x = Utils.approach(self.physics.speed_x, 12, 0.8*DTMULT)
        else
            self.physics.speed_x = Utils.approach(self.physics.speed_x, 12, 0.4*DTMULT)
        end
    else
        if self.physics.speed_x > 0 then
            self.physics.speed_x = Utils.approach(self.physics.speed_x, -12, 0.8*DTMULT)
        else
            self.physics.speed_x = Utils.approach(self.physics.speed_x, -12, 0.4*DTMULT)
        end
    end
end

function Cyclone:hit(source, damage)
    if math.abs(self.x - source.x) < 16 then
        self.physics.speed_y = self.physics.speed_y*-1
        super:hit(self, source, damage)
    else
        self.curr_knockback = 8
        self.knockback_dir = (self.x < source.x) and math.pi or 0
    end
end

function Cyclone:onDefeat()
    self.enemy.health = 9
end

return Cyclone