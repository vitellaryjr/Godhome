local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 8
    if Game.battle.encounter.difficulty > 1 then
        self:setArenaSize(240)
    else
        self:setArenaSize(200)
    end
    self:setSoulOffset(0,80)
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul

    if Game.battle.encounter.difficulty > 1 then
        self:spawnObject(Solid(true, arena.x - 80, arena.y - 80, 40, 40))
        self:spawnObject(Solid(true, arena.x + 40, arena.y - 80, 40, 40))
        self:spawnObject(Solid(true, arena.x - 80, arena.y + 40, 40, 40))
        self:spawnObject(Solid(true, arena.x + 40, arena.y + 40, 40, 40))
    end

    local markoth = self:spawnBullet("p4/markoth/markoth", arena.x, arena.y)
    local anchor = Anchor(0.5, 0.5)
    markoth:addChild(anchor)
    local shield = self:spawnBulletTo(anchor, "p4/markoth/shield", 30, math.pi)
    self.timer:every(3, function()
        if love.math.random() < 0.5 then
            shield:changeSpin()
        end
    end)

    self.timer:every(0.8, function()
        local angle = Utils.random(math.pi*2)
        self:spawnBullet("p4/markoth/nail", soul.x + 60*math.cos(angle), soul.y + 60*math.sin(angle))
    end)
end

return Swords