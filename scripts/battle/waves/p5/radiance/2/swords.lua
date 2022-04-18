local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = -1
    self:setArenaSize(180)
    self:setArenaOffset(0, 40)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local radiance = self:spawnBullet("p5/radiance/radiance", arena.x, arena.top + arena.height/4)
    radiance:setSprite("battle/p5/radiance/boss_angry", 0.15, true)
    self.timer:everyInstant(0.7, function()
        local rows = Utils.pickMultiple({-3,-2,-1,0,1,2,3}, 5)
        local offset = love.math.random(-10,10)
        for _,row in ipairs(rows) do
            local sword = self:spawnBullet("p5/radiance/sword", arena.x + row*25 + offset, -30, math.pi/2)
            sword:launch(8)
        end
    end)
end

return Swords