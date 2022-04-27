local Circle, super = Class(Wave)

function Circle:init()
    super:init(self)

    self.time = 7
    self:setArenaSize(160)
    self:setSoulOffset(0,40)

    self.spin = 0
end

function Circle:onStart()
    local arena = Game.battle.arena
    self.mace = self:spawnBullet("p4/failedchamp/mace", arena.x, arena.y, 3*math.pi/2, 64)
    self.timer:every(1.5, function()
        Game.battle.encounter:spawnRocks(self, Game.battle:getEnemyByID("p4/failedchamp").phase, 0.2)
    end)
end

function Circle:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.mace then
        self.spin = Utils.approach(self.spin, 0.1, 0.005*DTMULT)
        local prev_dir = self.mace.dir
        self.mace:rotate(self.mace.dir + self.spin*DTMULT)
        if self.mace.dir % (math.pi/2) < prev_dir % (math.pi/2) then -- passed a cardinal
            local side = Utils.round(self.mace.dir, math.pi/2)
            local x, y = arena.x + arena.width/2*math.cos(side), arena.y + arena.height/2*math.sin(side)
            local s1 = self:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 40, 4)
            local s2 = self:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 40, -4)
            s1.rotation = side - (math.pi/2)
            s2.rotation = side - (math.pi/2)
            Game.battle.shake = 3
        end 
    end
end

return Circle