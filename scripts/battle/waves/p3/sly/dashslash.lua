local DashSlash, super = Class(Wave)

function DashSlash:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(160)
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

    self.timer:everyInstant(1.2, function()
        local side = Utils.pick(sides)
        self:spawnBullet("p3/sly/dashslash", side.x, side.y, side.dir)
    end)
end

return DashSlash