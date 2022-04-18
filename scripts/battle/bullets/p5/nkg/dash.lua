local Dash, super = Class(Bullet)

function Dash:init(x, y)
    super:init(self, x, y, "battle/p5/nkg/dash")
    self:setHitbox(6, 3, 27, 7)
    self.rotation = math.pi/2
end

function Dash:onAdd(parent)
    super:onAdd(self, parent)
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.wave.timer:script(function(wait)
        wait(0.3)
        while true do
            local angle = Utils.angle(self, soul)
            while Utils.round(self.rotation % (math.pi*2), 0.1) ~= Utils.round(angle % (math.pi*2), 0.1) do
                self.rotation = Utils.approachAngle(self.rotation, angle, 0.4*DTMULT)
                wait()
            end
            wait(0.1)
            self.physics = {
                speed = 14,
                match_rotation = true,
            }
            self.wave.timer:everyInstant(0.05, function()
                self.wave:spawnBullet("p5/nkg/fireTrail", self.x, self.y, self.rotation)
            end, 5)
            wait(0.2)
            self.physics.friction = 3
            wait(0.25)
        end
    end)
end

return Dash