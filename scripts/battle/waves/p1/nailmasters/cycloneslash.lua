local CycloneSlash, super = Class(Wave)

function CycloneSlash:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(160)
    self:setArenaOffset(0,40)
end

function CycloneSlash:onStart()
    local arena = Game.battle.arena
    local sides = {
        {x=arena.left, y=arena.y, dir=0},
        {x=arena.x, y=arena.top, dir=math.pi/2},
        {x=arena.right, y=arena.y, dir=math.pi},
        {x=arena.x, y=arena.bottom, dir=math.pi*3/2},
    }

    local side_i = love.math.random(4)
    local side = sides[side_i]
    self:spawnBulletTo(Game.battle.mask, "p1/nailmasters/cycloneslash", side.x, side.y, side.dir)
    self.timer:every(2, function()
        side_i = love.math.random(4)
        side = sides[side_i]
        self:spawnBulletTo(Game.battle.mask, "p1/nailmasters/cycloneslash", side.x, side.y, side.dir)
    end)
    if #Game.battle.enemies == 2 then
        self.timer:after(1.2, function()
            self.timer:everyInstant(2, function()
                self:spawnNail(side.dir)
            end)
        end)
    end
end

function CycloneSlash:spawnNail(dir)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local x,y,w,h = arena.x, arena.y, arena.width, arena.height
    if dir % math.pi == 0 then -- horizontal
        self:spawnBullet("p1/nailmasters/nail", x+(w/2+50)*math.cos(dir), soul.y, dir+math.pi)
    else -- vertical
        self:spawnBullet("p1/nailmasters/nail", soul.x, y+(h/2+50)*math.sin(dir), dir+math.pi)
    end
end

return CycloneSlash