local Pufferfish, super = Class(Wave)

function Pufferfish:init()
    super:init(self)
    self.time = 9
    self:setArenaSize(300, 160)
    self:setSoulOffset(0, 20)
end

function Pufferfish:onStart()
    local arena = Game.battle.arena
    local bx, by = arena.x, arena.top + 30
    self:spawnBullet("p5/nkg/balloon", bx, by)
    self.timer:every(0.8, function()
        self:spawnBulletTo(Game.battle.mask, "p5/nkg/pufferFireball", bx, by + 10, 6, math.pi/2 + Utils.random(-0.1, 0.1))
    end)
    self.timer:every(0.55, function()
        for _,speed in ipairs(Utils.pickMultiple({4.5, 8, 11.5}, 2)) do
            local angle = math.pi*(0.55 - 0.01*((speed-1)/3.5))
            self:spawnBulletTo(Game.battle.mask, "p5/nkg/pufferFireball", bx - 10, by + 12, speed, angle, 0.18)
        end
        for _,y in ipairs(Utils.pickMultiple({28, 4, -20}, 2)) do
            self:spawnBulletTo(Game.battle.mask, "p5/nkg/pufferFireball", bx + love.math.random(0, 12), by + y, 0, math.pi, 0.05)
        end
        for _,speed in ipairs(Utils.pickMultiple({4.5, 8, 11.5}, 2)) do
            local angle = math.pi*(0.45 + 0.01*((speed-1)/3.5))
            self:spawnBulletTo(Game.battle.mask, "p5/nkg/pufferFireball", bx + 10, by + 12, speed, angle, 0.18)
        end
        for _,y in ipairs(Utils.pickMultiple({28, 4, -20}, 2)) do
            self:spawnBulletTo(Game.battle.mask, "p5/nkg/pufferFireball", bx - love.math.random(0, 12), by + y, 0, 0, 0.05)
        end
    end)
end

return Pufferfish