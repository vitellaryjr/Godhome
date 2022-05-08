local NoEyes, super = Class("nailbase")

function NoEyes:init()
    super:init(self, 0, 0, "battle/p4/noeyes/noeyes")
    self.sprite:play(0.4, true)
    self:setHitbox(11, 11, 9, 11)

    self.enemy = Game.battle:getEnemyBattler("p4/noeyes")

    self.center_collider = PointCollider(self, 15, 18)
    self.sine = Utils.random(math.pi*3)
    self.ox, self.oy = 0, 0
    self.tele_cooldown = 0

    self.timer = Timer()
    self:addChild(self.timer)

    self:teleport(false)
end

function NoEyes:onAdd(parent)
    super:onAdd(self, parent)
    self.timer:script(function(wait)
        while true do
            local time = Utils.clampMap(self.enemy.health, 0,self.enemy.max_health, 0.8,2)
            wait(Utils.random(time, time*2))
            if self.tele_cooldown > 0 then
                wait(time/2)
            end
            self:teleport(true)
        end
    end)
end

function NoEyes:update()
    super:update(self)
    self.tele_cooldown = Utils.approach(self.tele_cooldown, 0, DT)
    self.sine = self.sine + DT
    self:setPosition(
        self.ox + 6*math.sin(self.sine*3),
        self.oy + 6*math.sin(self.sine*2)
    )
end

function NoEyes:hit(source, damage)
    if love.math.random() < 0.3 then
        self:teleport()
    else
        self.knockback = 6
    end
    super:hit(self, source, damage)
    self.knockback = 0
end

function NoEyes:teleport(flash)
    local arena, soul = Game.battle.arena, Game.battle.soul
    local x, y = 0, 0
    self:setPosition(x, y)
    while (math.abs(self.x - soul.x) < 48 and math.abs(self.y - soul.y) < 48) or not self.center_collider:collidesWith(arena.area_collider) do
        x, y = love.math.random(arena:getLeft(), arena:getRight()), love.math.random(arena:getTop(), arena:getBottom())
        self:setPosition(x, y)
    end
    self.ox, self.oy = x, y
    self.tele_cooldown = 0.5
    if flash then
        self.color = {1,1,1}
        self.timer:tween(0.5, self.color, {1, 0.8, 0.5})
    end
end

return NoEyes