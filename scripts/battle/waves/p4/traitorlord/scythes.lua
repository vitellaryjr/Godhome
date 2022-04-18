local Scythes, super = Class(Wave)

function Scythes:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(200, 140)
end

function Scythes:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("common/arenathorns", arena)
    self.timer:after(0.5, function()
        self.timer:everyInstant(1.5, function()
            local speed = Utils.random(3,4)
            local freq = Utils.random(3,3.5)
            if soul.x > arena.x then
                self:spawnBullet("p4/traitorlord/sine", arena.left - 50, speed, freq)
                self:spawnBullet("p4/traitorlord/sine", arena.left - 50, speed*2, freq)
            else
                self:spawnBullet("p4/traitorlord/sine", arena.right + 50, -speed, freq)
                self:spawnBullet("p4/traitorlord/sine", arena.right + 50, -speed*2, freq)
            end
        end)
    end)
end

return Scythes