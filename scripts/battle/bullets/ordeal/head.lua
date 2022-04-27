local Head, super = Class("ordeal/zotebase")

function Head:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.top, "battle/ordeal/head_fall")
    self:setOrigin(0.5, 1)
    self:setHitbox(3,30, 33,21)
    self.collidable = false
    self.health = 120
    self.immune = true

    self.physics = {
        speed_y = 4,
        friction = 1,
    }
    self.shaking = false
    self.falling = false
    self.defeated = false
end

function Head:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.timer = Timer()
    self:addChild(self.timer)
    self.timer:script(function(wait)
        wait(1)
        self.shaking = true
        wait(0.5)
        self.shaking = false
        self.falling = true
        self.collidable = true
        self.physics = {
            speed_y = 15,
        }
        while self.y < arena.bottom do
            wait()
        end
        self.falling = false
        self.y = arena.bottom
        self.physics = {}
        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 80, 120, 4)
        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.bottom, 80, 120, -4)
        wait(0.4)
        self:setSprite("battle/ordeal/head_stop")
        wait(8)
        self:setSprite("battle/ordeal/head_fall")
        self.shaking = true
        wait(1)
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        self.physics = {
            speed_y = -20,
        }
        while self.y > arena.top + 40 do
            wait()
        end
        local s1 = self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.top, 80, 100, 4)
        local s2 = self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", self.x, arena.top, 80, 100, -4)
        s1.rotation = math.pi
        s2.rotation = math.pi
    end)
end

function Head:update()
    super:update(self)
    if self.shaking then
        self.sprite.x = love.math.random(-1,1)
    else
        self.sprite.x = 0
    end
    if self.falling then
        for _,zote in ipairs(self.wave.zotes) do
            if zote ~= self and not zote.immune and zote:collidesWith(self) then
                zote:onDefeat()
            end
        end
    end
end

function Head:onDefeat()
    self.timer:remove()
    super:onDefeat(self)
end

function Head:killAnim()
    self:setSprite("battle/ordeal/head_crack")
    self.defeated = true
    self.collidable = false
    self.shaking = false
    self.wave.timer:after(0.5, function()
        local x,y,w,h = self:getHitbox()
        self:addChild(ParticleEmitter(x,y,w*2,h*2, {
            shape = "triangle",
            alpha = 0.5,
            size = {12,16},
            speed = {2,3},
            friction = 0.05,
            spin = {-0.3,0.3},
            fade = {0.05,0.1},
            fade_after = {0.2,1},
            amount = {10,12},
        }))
        self:remove()
    end)
end

return Head