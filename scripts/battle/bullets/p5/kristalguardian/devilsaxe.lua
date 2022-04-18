local Axe, super = Class(Bullet)

function Axe:init(x, y, angle, dist)
    super:init(self, x + math.cos(angle)*dist, y + math.sin(angle)*dist, "battle/p5/kristalguardian/devilsaxe")
    self:setScale(1)
    self.collider = CircleCollider(self, self.width/2, self.height/2, 16)
    self.double_damage = true
    
    self.ox, self.oy = x, y
    self.angle = angle
    self.dist = dist
    self.sine = math.pi/2
    self.spinning = 0
end

function Axe:update(dt)
    super:update(self, dt)
    if self.spinning > 0 then
        self.sine = self.sine + 0.08*DTMULT*self.spinning
        self.angle = self.angle + 0.04*DTMULT*self.spinning
        self.graphics.spin = 0.2*self.spinning
        self:setPosition(self.ox + math.cos(self.angle)*math.sin(self.sine)*self.dist, self.oy + math.sin(self.angle)*math.sin(self.sine)*self.dist)
    end
end

return Axe