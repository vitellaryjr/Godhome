local Blades, super = Class(Wave)

function Blades:init()
    super:init(self)
    self.time = 8
end

function Blades:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    self.timer:everyInstant(1.5, function()
        self:spawnBullet("p2/mantislords/scythe", arena.x + arena.width, arena.top, soul.x, soul.y)
        self:spawnBullet("p2/mantislords/scythe", arena.x - arena.width, arena.top, soul.x, soul.y)
    end)

    local x,y,w,h = arena.x, arena.y, arena.width, arena.height
    local sides = {
        -- down
        {x=x-w/4, y=y-h, dir=math.pi/2},
        {x=x+w/4, y=y-h, dir=math.pi/2},
        -- up
        {x=x-w/4, y=y+h, dir=math.pi*3/2},
        {x=x+w/4, y=y+h, dir=math.pi*3/2},
    }
    local enemy = Utils.pick(Game.battle:getActiveEnemies())
    local prev_side

    self.timer:every(1.5, function()
        local side = Utils.pick(sides, function(v) return v ~= prev_side end)
        local lance = self:spawnBullet("p2/mantislords/lance", side.x, side.y, side.dir)
        lance.enemy = enemy
        prev_side = side
    end)
end

function Blades:onEnd()
    for _,scythe in ipairs(Game.stage:getObjects(Registry.getBullet("p2/mantislords/dash_scythe"))) do
        scythe.top:remove()
        scythe.bottom:remove()
    end
end

return Blades