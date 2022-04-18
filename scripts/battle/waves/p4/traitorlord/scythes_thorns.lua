local Scythes, super = Class(Wave)

function Scythes:init()
    super:init(self)
    self.time = 7
    self:setArenaShape(unpack(Utils.pick{
        {{0,0}, {100,0}, {150,30}, {200,40}, {200,160}, {160,160}, {120,140}, {80,140}, {40,100}, {0,40}},
        {{0,80}, {50,60}, {90,20}, {140,0}, {190,0}, {200, 50}, {200, 160}, {0, 140}},
        -- {{0,10}, {100,0}, {140,60}, {200,140}, {200,160}, {100,160}, {80,120}, {0,40}},
        {{10,60}, {20,20}, {60,10}, {200,0}, {190,100}, {180,140}, {140,150}, {0,160}},
    }))
end

function Scythes:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    self:spawnBullet("common/arenathorns", arena)
    self.timer:after(0.5, function()
        self.timer:everyInstant(1.5, function()
            local speed = Utils.random(2,3)
            local freq = Utils.random(3,3.5)
            if soul.x > arena.x then
                self:spawnBullet("p4/traitorlord/sine", arena.left - 50, speed, freq)
                self:spawnBullet("p4/traitorlord/sine", arena.left - 50, speed*2.5, freq)
            else
                self:spawnBullet("p4/traitorlord/sine", arena.right + 50, -speed, freq)
                self:spawnBullet("p4/traitorlord/sine", arena.right + 50, -speed*2.5, freq)
            end
        end)
    end)
end

return Scythes