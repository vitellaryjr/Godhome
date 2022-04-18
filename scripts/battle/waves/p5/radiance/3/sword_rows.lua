local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 9
    self:setArenaSize(288,240)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    for x=0,arena.width/16 - 1 do
        local spike_b = self:spawnBullet("p5/radiance/spike", arena.left + x*16, arena.bottom)
        spike_b.tp = 0
        local spike_t = self:spawnBullet("p5/radiance/spike", arena.right - x*16, arena.top)
        spike_t.rotation = math.pi
        spike_t.tp = 0
    end
    local x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
    local radiance = self:spawnBullet("p5/radiance/radiance", x, y)
    self.timer:everyInstant(0.8, function()
        local row_dir = love.math.random() < 0.5 and 0 or math.pi
        local rows = Utils.pickMultiple({-4,-3,-2,-1,0,1,2,3,4}, 6)
        local offset = love.math.random(-10,10)
        for _,row in ipairs(rows) do
            local sword = self:spawnBullet("p5/radiance/sword", arena.x - math.cos(row_dir)*360, arena.y + row*25 + offset, row_dir)
            sword:launch(8)
        end
    end)
    self.timer:every(2, function()
        x, y = love.math.random(arena.left + arena.width/4, arena.right - arena.width/4), love.math.random(arena.top + arena.height/4, arena.bottom - arena.height/4)
        radiance:teleport(x, y)
    end)
end

return Swords