local XeroSword, super = Class(Bullet)

function XeroSword:init(xero, ox, oy, buff)
    self.xero = xero
    super:init(self, xero.x+ox, xero.y+oy, "battle/p2/xero/sword")
    self.rotation = math.pi/2
    self.physics.match_rotation = true
    self:setHitbox(12,2.5,6,1.5)
    self.remove_offscreen = false

    self.buff = buff
    self.ox, self.oy = ox, oy

    self.state = "idle"
end

function XeroSword:update()
    super:update(self)
    if self.state == "idle" or self.state == "preparing" then
        self:setPosition(self.xero.x + self.ox, self.xero.y + self.oy)
    elseif self.state == "attacking" then
        self.physics.speed = Utils.approach(self.physics.speed, 32, (self.buff and 3 or 2)*DTMULT)
    end
end

function XeroSword:attack()
    local arena = Game.battle.arena
    self.state = "preparing"
    self.wave.timer:script(function(wait)
        local spin = 0
        while spin < 3*math.pi do
            spin = spin + 1.2*DTMULT
            self.rotation = math.pi/2 + spin
            wait()
        end
        self.rotation = -math.pi/2
        local soul = Game.battle.soul
        while true do
            local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
            self.rotation = Utils.approach(self.rotation, angle, 1.2*DTMULT)
            if self.rotation == angle then
                break
            end
            wait()
        end
        wait(0.3)
        self.state = "attacking"
        self.grazed = false
        while self.y < arena.bottom - 20 do
            wait()
        end
        self.state = "stopped"
        self.physics.speed = 0
        wait(0.1)
        self.state = "returning"
        self.lerp = 0
        self.wave.timer:tween(self.buff and 0.4 or 0.5, self, {lerp = 1}, "in-quad")
        local sx, sy = self:getPosition()
        while self.lerp ~= 1 do
            self:setPosition(
                Utils.lerp(sx, self.xero.x + self.ox, self.lerp),
                Utils.lerp(sy, self.xero.y + self.oy, self.lerp)
            )
            self.rotation = Utils.lerp(self.rotation, math.pi/2, self.lerp*2)
            wait()
        end
        self.state = "idle"
    end)
end

return XeroSword