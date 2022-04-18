local Flukefey, super = Class("nailbase")

function Flukefey:init(x, y, dir)
    super:init(self, x, y, "battle/p2/flukemarm/fey")
    self.sprite:play(0.2, true)
    self:setHitbox(6,4.5,9,9)
    self.rotation = dir
    self.physics = {
        speed_x = 8*math.cos(dir),
        speed_y = 8*math.sin(dir),
    }
    self.health = 30
end

function Flukefey:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(0.1, function()
        self.layer = self.layer + 2
    end)
end

function Flukefey:hit(source, damage)
    super:hit(self, source, damage)
    local angle_to = Utils.angle(self.x, self.y, source.x, source.y)
    self.rotation = Utils.approachAngle(self.rotation, angle_to, -math.pi/2)
    self.physics = {
        speed_x = 8*math.cos(self.rotation),
        speed_y = 8*math.sin(self.rotation),
    }
end

function Flukefey:update(dt)
    super:update(self, dt)
    local soul = Game.battle.soul
    local angle_to = Utils.angle(self.x, self.y, soul.x, soul.y)
    self.physics.speed_x = Utils.approach(self.physics.speed_x, 8*math.cos(angle_to), 0.4*DTMULT)
    self.physics.speed_y = Utils.approach(self.physics.speed_y, 8*math.sin(angle_to), 0.4*DTMULT)
    self.rotation = Utils.angle(0, 0, self.physics.speed_x, self.physics.speed_y)
end

return Flukefey