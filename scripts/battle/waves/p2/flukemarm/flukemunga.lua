local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
    self:setSoulOffset(0, 60)
end

function Charge:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p2/flukemarm/flukemarm", arena.x, arena.y)
    self.timer:after(0.5, function()
        self.timer:everyInstant(1.6, function()
            self:spawnFluke()
        end)
    end)
end

function Charge:spawnFluke()
    local arena = Game.battle.arena
    local corner = Mod:openArenaCorner(arena, 30, 0.2)
    local dir = corner.side*math.pi/2
    local half = corner.half
    local x, y = arena.x, arena.y
    if corner.side == 1 then
        x = arena.x + arena.width/2*half
        y = arena:getTop() - 40
    elseif corner.side == 2 then
        x = arena:getRight() + 40
        y = arena.y + arena.height/2*half
    elseif corner.side == 3 then
        x = arena.x - arena.width/2*half
        y = arena:getBottom() + 40
    else
        x = arena:getLeft() - 40
        y = arena.y - arena.height/2*half
    end
    local ps = ParticleEmitter(Utils.approach(x, arena.x, 20*math.abs(math.sin(dir))), Utils.approach(y, arena.y, 20*math.abs(math.cos(dir))), {
        shape = "circle",
        width = 12, height = {2,4},
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
    })
    self:addChild(ps)
    self.timer:after(0.7, function()
        ps:remove()
        if corner.side == 1 then
            y = y - 20
        elseif corner.side == 2 then
            x = x + 20
        elseif corner.side == 3 then
            y = y + 20
        else
            x = x - 20
        end
        self:spawnBulletTo(Game.battle.mask, "p2/flukemarm/flukemunga", x, y, dir, half)
    end)
    self.timer:after(1.2, function()
        Mod:revertArenaCorner(arena, 0.2)
    end)
end

return Charge