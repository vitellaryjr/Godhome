local Dash, super = Class(Wave)

function Dash:init()
    super:init(self)
    self.time = 7
    self:setArenaOffset(0, 20)
end

function Dash:onStart()
    local arena = Game.battle.arena
    local x,y,w,h = arena.x, arena.y, arena.width, arena.height
    local sides = {
        -- left
        {x=x-w, y=y-h/4, dir=0},
        {x=x-w, y=y+h/4, dir=0},
        -- down
        {x=x-w/4, y=y-h, dir=math.pi/2},
        {x=x+w/4, y=y-h, dir=math.pi/2},
        -- right
        {x=x+w, y=y-h/4, dir=math.pi},
        {x=x+w, y=y+h/4, dir=math.pi},
        -- up
        {x=x-w/4, y=y+h, dir=math.pi*3/2},
        {x=x+w/4, y=y+h, dir=math.pi*3/2},
    }
    local enemies = Game.battle:getActiveEnemies()
    local enemy_i = 1
    local every = ({1.5, 1.1, 0.8})[#enemies]
    local prev_side

    self.timer:everyInstant(every, function()
        local side = Utils.pick(sides, function(v) return v ~= prev_side end)
        local lance = self:spawnBullet("p2/mantislords/lance", side.x, side.y, side.dir, #enemies == 3)
        lance.enemy = enemies[enemy_i]
        prev_side = side
        enemy_i = (enemy_i % #enemies) + 1
    end)
end

function Dash:onEnd()
    for _,scythe in ipairs(Game.stage:getObjects(Registry.getBullet("p2/mantislords/dash_scythe"))) do
        scythe.top:remove()
        scythe.bottom:remove()
    end
end

return Dash