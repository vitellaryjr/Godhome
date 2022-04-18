local Spike, super = Class("nailbase")

function Spike:init(x, y, enemy)
    super:init(self, x, y, "battle/p3/grimm/spike_spawn")
    self.sprite:play(0.05, false)
    self:setOrigin(0.5, 1)
    self:setHitbox(6, 0, 4, 70)
    self.collidable = false
    self.nail_hb = Hitbox(self, 6, 0, 4, 70)
    self.nail_hb.collidable = false
    if enemy then
        self.enemy = enemy
    else
        self.color = {1,1,1}
        self.tp = 1.6
    end
end

function Spike:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(0.5, function()
        self:setSprite("battle/p3/grimm/spike_extend", 0.03, false)
        self.wave.timer:after(0.09, function()
            self.collidable = true
            if self.enemy then
                self.nail_hb.collidable = true
            end
        end)
    end)
    self.wave.timer:after(1.2, function()
        self.collidable = false
        self.nail_hb.collidable = false
        self:setSprite("battle/p3/grimm/spike_retract", 0.05, false, function(sprite) self:remove() end)
    end)
end

function Spike:hit(source, damage)
    if self.enemy then
        local prev_hp = self.enemy.health
        super:hit(self, source, damage)
        if prev_hp ~= self.enemy.max_health and (self.enemy.health % (self.enemy.max_health/3) > prev_hp % (self.enemy.max_health/3)) then
            self.enemy.pufferfish = true
        end
    else
        super:hit(self, source, damage)
    end
end

function Spike:getPlayerKnockbackDir(source)
    if source.x > self.x then
        return 0
    else
        return math.pi
    end
end

return Spike