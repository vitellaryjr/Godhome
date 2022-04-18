local Vessels, super = Class(Wave)

function Vessels:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180, 160)
    self:setSoulOffset(0, 40)
end

function Vessels:onStart()
    local arena = Game.battle.arena
    for i=1,3 do
        local x = love.math.random(arena.left, arena.right)
        local y = love.math.random(arena.top, arena.top + arena.height/4)
        local vessel = self:spawnBullet("p2/nosk/vessel", x, y)
        vessel.layer = vessel.layer + i
    end
end

return Vessels