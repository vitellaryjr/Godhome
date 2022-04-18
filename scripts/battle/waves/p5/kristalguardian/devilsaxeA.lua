local Devilsknife, super = Class(Wave)

function Devilsknife:init()
    super:init(self)
    self.time = 7
end

function Devilsknife:onStart()
    local arena = Game.battle.arena
    for i=1,4 do
        local angle = -math.pi/6 + i*math.pi/2
        local axe = self:spawnBullet("p5/kristalguardian/devilsaxe", arena.x, arena.y, angle, arena.width)
        self.timer:after(0.5, function()
            self.timer:tween(0.5, axe, {spinning = 1})
        end)
    end
end

return Devilsknife