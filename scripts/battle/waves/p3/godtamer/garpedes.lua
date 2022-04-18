local Garpedes, super = Class(Wave)

function Garpedes:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(180,140)

    self.arena_change = nil
end

function Garpedes:onStart()
    local arena = Game.battle.arena
    local amt = 0
    self.timer:everyInstant(1.4, function()
        amt = amt + 1
        local c_num = math.floor(arena.width/36)
        local c = love.math.random(math.ceil(c_num - c_num*3/2), math.floor(c_num - c_num*1/2))
        if amt%3 == 0 then
            c = Utils.round(Game.battle.soul.x - arena.x, 36)/36
        end
        local x = arena.x + 36*c
        self:spawnBulletTo(Game.battle.mask, "p3/godtamer/garpede", x, arena:getTop() - 40, math.pi/2, 4, 4)
    end)
    if Game.battle:getEnemyByID("p3/godtamer") then
        self.timer:after(1.1, function()
            if self.arena_change ~= "resize_h" then
                self.timer:everyInstant(3, function()
                    self:spawnBullet("p3/godtamer/tamer", 480, Game.battle.soul.x, 2.3)
                end)
            end
        end)
    end
    self.timer:after(1, function()
        local chance = love.math.random()
        if chance < 0.1 or not Game.battle.encounter.seen_full_waves[self.id] then
            self.arena_change = "nothing"
            Game.battle.encounter.seen_full_waves[self.id] = true
        elseif chance < 0.4 then
            self.arena_change = "resize_h"
            self.resize_h = 180
            self.timer:during(1, function(dt)
                self:setArenaSize(180+love.math.random(-2,2), 140)
            end, function()
                self.timer:tween(0.2, self, {resize_h = 108})
                self.timer:during(0.3, function(dt)
                    self:setArenaSize(self.resize_h, 140)
                end)
            end)
        elseif chance < 0.7 then
            self.arena_change = "resize_v"
            self.resize_v = 140
            arena:shiftOrigin(0.5,1)
            self.timer:during(1, function(dt)
                self:setArenaSize(180, 140+love.math.random(-1,1))
            end, function()
                self.timer:tween(0.2, self, {resize_v = 100})
                self.timer:during(0.3, function(dt)
                    self:setArenaSize(180, self.resize_v)
                end)
            end)
        else
            self.arena_change = "spikes"
            local spikes = {}
            for i=-2,2 do
                local x = arena.x + 36*i
                local spike = self:spawnBulletTo(Game.battle.mask, "p3/godtamer/spikes", x, arena:getBottom() + 20, -math.pi/2)
                spike:activate()
            end
        end
    end)
end

return Garpedes