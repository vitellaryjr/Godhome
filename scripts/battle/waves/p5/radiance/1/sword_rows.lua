local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("p5/radiance/radiance", love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), arena.top + arena.height/4)
    self.timer:everyInstant(0.8, function()
        local row_dir = love.math.random() < 0.5 and 0 or math.pi
        local rows = Utils.pickMultiple({-3,-2,-1,0,1,2,3}, 5)
        local offset = love.math.random(-10,10)
        for _,row in ipairs(rows) do
            local sword = self:spawnBullet("p5/radiance/sword", arena.x - math.cos(row_dir)*360, arena.y + row*25 + offset, row_dir)
            sword:launch(8)
        end
    end)
end

return Swords