local DashSlash, super = Class(Wave)

function DashSlash:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(160)
    self:setArenaOffset(0,40)
end

function DashSlash:onStart()
    local arena = Game.battle.arena
    local x,y,w,h = arena.x, arena.y, arena.width, arena.height
    local sides = {
        -- left
        {x = x-w/2, y=y+h/4, dir=0},
        {x = x-w/2, y=y-h/4, dir=0},
        -- top
        {x = x-w/4, y=y-h/2, dir=math.pi/2},
        {x = x+w/4, y=y-h/2, dir=math.pi/2},
        -- right
        {x = x+w/2, y=y-h/4, dir=math.pi},
        {x = x+w/2, y=y+h/4, dir=math.pi},
        -- bottom
        {x = x+w/4, y=y+h/2, dir=math.pi*3/2},
        {x = x-w/4, y=y+h/2, dir=math.pi*3/2},
    }

    local side = Utils.pick(sides)
    self:spawnBullet("p1/nailmasters/dashslash", side.x, side.y, side.dir)
    self.timer:every(2, function()
        side = Utils.pick(sides)
        self:spawnBullet("p1/nailmasters/dashslash", side.x, side.y, side.dir)
    end)
    if #Game.battle.enemies == 2 then
        self.timer:after(0.5, function()
            self:spawnNail(side)
            self.timer:every(2, function()
                self:spawnNail(side)
            end)
        end)
    end
end

function DashSlash:spawnNail(side)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local x,y,w,h = arena.x, arena.y, arena.width, arena.height
    local dir = 0
    if side.x < x and math.abs(side.x-x) < math.abs(side.y-y) then -- left column
        dir = 0
    elseif side.x > x and math.abs(side.x-x) < math.abs(side.y-y) then -- right column
        dir = math.pi
    elseif side.y < y and math.abs(side.y-y) < math.abs(side.x-x) then -- top row
        dir = math.pi/2
    elseif side.y > y and math.abs(side.y-y) < math.abs(side.x-x) then -- bottom row
        dir = -math.pi/2
    end
    if dir % math.pi == 0 then -- horizontal
        self:spawnBullet("p1/nailmasters/nail", x+(w/2+50)*math.cos(dir+math.pi), soul.y, dir)
    else -- vertical
        self:spawnBullet("p1/nailmasters/nail", soul.x, y+(h/2+50)*math.sin(dir+math.pi), dir)
    end
end

return DashSlash