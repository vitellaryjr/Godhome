local Sword, super = Class(Wave)

function Sword:init()
    super:init(self)
    self.time = 8
end

function Sword:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    local x, y = arena.x + 50*Utils.randomSign(), arena.y + 50*Utils.randomSign()
    local angle = Utils.angle(x, y, soul.x, soul.y)
    self.b = self:spawnBullet("p3/hiveknight/swordbee", x, y, angle)
    self.timer:script(function(wait)
        wait(0.2)
        self.b:charge()
        wait(1)
        while true do
            if love.math.random() < 0.4 then
                self.b:teleport()
                wait(1.3)
            else
                self.b:charge()
                wait(1)
            end
        end
    end)
end

return Sword