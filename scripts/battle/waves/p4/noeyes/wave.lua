local Spirits, super = Class(Wave)

function Spirits:init()
    super:init(self)
    self.time = 8
    if Game.battle.encounter.difficulty > 1 then
        self:setArenaShape({0,0}, {45,0}, {65,60}, {85,0}, {180,0}, {180,180}, {135,180}, {115,120}, {95,180}, {0,180})
    else
        self:setArenaSize(170)
    end
end

function Spirits:onStart()
    local arena = Game.battle.arena
    if Game.battle.encounter.difficulty > 1 then
        self:spawnBullet("common/arenathorns", arena)
    end
    Game.battle.encounter.singing:fade(0.5, 1)
    self.noeyes = self:spawnBullet("p4/noeyes/noeyes")
    local enemy = Game.battle:getEnemyBattler("p4/noeyes")
    local dir = Utils.randomSign()
    self.timer:script(function(wait)
        while true do
            self:spawnBullet("p4/noeyes/ghost", arena.x + -360*dir, love.math.random(arena.top, arena.bottom), dir)
            if love.math.random() < 1 then
                dir = dir*-1
            end
            wait(Utils.clampMap(enemy.health, 0,enemy.max_health, 0.5,0.8) + Utils.random(-0.2, 0.2))
        end
    end)
end

function Spirits:update()
    super:update(self)
    if self.noeyes then
        local soul = Game.battle.soul
        local dist_x, dist_y = self.noeyes.x - soul.x, self.noeyes.y - soul.y
        Game.battle.encounter.singing.source:setPosition(Utils.clampMap(dist_x, -170, 170, -1, 1), Utils.clampMap(dist_y, -170, 170, -1, 1))
        Game.battle.encounter.singing.source:setVolume(Utils.clampMap(math.abs(dist_x), 0, 170, 0.5, 0.2))
    end
end

function Spirits:onEnd()
    Game.battle.encounter.singing:fade(0, 1)
end

return Spirits