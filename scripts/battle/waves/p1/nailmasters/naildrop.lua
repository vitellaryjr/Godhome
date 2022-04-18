local NailDrop, super = Class(Wave)

function NailDrop:init()
    super:init(self)
    self.time = 5
    self:setArenaSize(160)
    self:setArenaOffset(0,40)
end

function NailDrop:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p1/nailmasters/nail", arena.x, arena.top - 50, math.pi/2)
    local soul = Game.battle.soul
    self.timer:every(1, function()
        self:spawnBullet("p1/nailmasters/nail", soul.x, arena.top - 50, math.pi/2)
        if #Game.battle.enemies == 2 then
            local x = soul.x + love.math.random(50,100)*Utils.randomSign()
            while x < arena.left+5 or x > arena.right-5 do
                x = soul.x + love.math.random(50,100)*Utils.randomSign()
            end
            self:spawnBullet("p1/nailmasters/nail", x, arena.top - 50, math.pi/2)
        end
    end)
end

return NailDrop