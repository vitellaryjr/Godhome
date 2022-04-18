local Flukes, super = Class(Wave)

function Flukes:init()
    super:init(self)
    self.time = 7.1
    self:setArenaSize(220)
    self:setSoulOffset(0, 60)
end

function Flukes:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p2/flukemarm/flukemarm", arena.x, arena.y)
    self:spawnFluke()
    self.timer:every(2, function()
        self:spawnFluke()
    end)
end

function Flukes:spawnFluke()
    local arena = Game.battle.arena
    local positions = {
        {x = 26, y = -16, dir = -0.1},
        {x = 18, y = 18, dir = math.pi/4},
        {x = -16, y = 24, dir = math.pi*5/6},
        {x = -14, y = -30, dir = math.pi*7/6},
    }
    local p = Utils.pick(positions)
    local x, y, dir = arena.x + p.x, arena.y + p.y, p.dir
    Game.battle:addChild(ParticleEmitter(x, y, {
        shape = "circle",
        width = 8, height = {1,3},
        rotation = dir,
        rotation_var = 0.3,
        angle = function(p) return p.rotation end,
        shrink = 0.05,
        shrink_after = {0.1,0.2},
        speed = 6,
        friction = 0.2,
        mask = true,
        every = 0.1,
        amount = {1,2},
        time = 0.5,
    }))
    self.timer:after(0.5, function()
        self:spawnBullet("p2/flukemarm/flukefey", x, y, dir)
    end)
end

return Flukes