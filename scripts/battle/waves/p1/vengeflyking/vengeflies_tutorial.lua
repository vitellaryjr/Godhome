local Vengefly, super = Class(Wave)

function Vengefly:init()
    super:init(self)

    self.time = 10
    self:setArenaSize(150)

    self.vengeflies = {}
end

function Vengefly:onStart()
    local arena = Game.battle.arena

    table.insert(self.vengeflies, self:spawnBullet("p1/vengeflyking/vengefly_tutorial", arena.left + 20, arena.top + 20 + love.math.random(arena.height-40)))
    table.insert(self.vengeflies, self:spawnBullet("p1/vengeflyking/vengefly_tutorial", arena.right - 20, arena.top + 20 + love.math.random(arena.height-40)))
    for i,vengefly in ipairs(self.vengeflies) do
        self.timer:after(2, function()
            if not vengefly.started then
                vengefly:startle((i == 1) and (-math.pi*3/4) or (-math.pi/4))
            end
        end)
    end
end

return Vengefly