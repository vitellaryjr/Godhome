local Gorb, super = Class("nailbase")

function Gorb:init(x, y)
    super:init(self, x, y, "battle/p1/gorb/idle")
    self.sprite:play(0.2, true)
    self:setHitbox(15,5, 9,27)

    self.enemy = Game.battle:getEnemyByID("p1/gorb")
    self.knockback = 4

    self.sine = 0
    self.mult = 1
    self.slowdown = false
    self.sx = x

    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        local soul = Game.battle.soul
        while true do
            wait(0.5)
            self.slowdown = true
            self.sprite:setAnimation{"battle/p1/gorb/charge", 0.2, true}
            wait(0.4)
            local row_count = 4 - math.ceil(self.enemy.health / (self.enemy.max_health/3)) -- 1-3
            local angle = Utils.angle(self, soul)
            for i=0,row_count-1 do
                for j=1,8 do
                    local sa = angle + j*math.pi/4 + i*math.pi/8
                    self.wave:spawnBullet("p1/gorb/spear", self.x+32*math.cos(sa), self.y+32*math.sin(sa), sa)
                end
                wait(0.3)
            end
            self.sprite:setAnimation{"battle/p1/gorb/idle", 0.2, true}
            self.slowdown = false
        end
    end)
end

function Gorb:update(dt)
    super:update(self, dt)
    if self.curr_knockback > 0 then
        self.sx = self.sx + self.curr_knockback*math.cos(self.knockback_dir)*DTMULT
    end
    self.mult = Utils.approach(self.mult, self.slowdown and 0 or 1, 0.07*DTMULT)
    self.sine = self.sine + 0.05*self.mult*DTMULT
    self.x = self.sx + 80*math.sin(self.sine)
end

function Gorb:onDefeat()
    super:onDefeat(self)
    self.wave.finished = true
end

return Gorb