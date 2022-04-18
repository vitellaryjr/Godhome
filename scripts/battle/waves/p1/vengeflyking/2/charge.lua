local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)

    self.time = 8
    self:setArenaSize(150)

    self.orig_data = {}
end

function Charge:onStart()
    local arena = Game.battle.arena

    for i,enemy in ipairs(Game.battle.enemies) do
        enemy.sprite:setAnimation("charge")
        self:spawnBulletTo(enemy.sprite, "p1/vengeflyking/chargeking", enemy)
        self.orig_data[enemy] = {x = enemy.x, y = enemy.y, layer = enemy.layer}
        enemy:setLayer(BATTLE_LAYERS["bullets"])

        self.timer:tween(0.7, enemy, {y = arena.top + 20}, "in-out-sine")
        self.timer:after(i*0.5 - 0.5, function()
            self.timer:after(1, function()
                self:charge(enemy, -i)
            end)
            self.timer:every(2.5, function()
                self:charge(enemy, i)
                self.timer:after(1.25, function()
                    self:charge(enemy, -i)
                end)
            end)
        end)
    end
end

function Charge:onEnd()
    for enemy,data in pairs(self.orig_data) do
        enemy.sprite:setAnimation("idle")
        enemy.scale_x = 2
        local x, y = data.x, data.y
        Game.battle.timer:tween(0.5, enemy, {x=x, y=y}, "out-sine", function()
            enemy:setLayer(data.layer)
        end)
    end
    super:onEnd(self)
end

function Charge:charge(enemy, dir)
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    local end_pos = arena.x + dir*100
    local target_y = soul.y + 30
    self.timer:tween(0.5, enemy, {y = target_y}, "out-sine", function()
        self.timer:tween(0.5, enemy, {y = arena.top + 20}, "in-sine")
    end)
    self.timer:tween(1, enemy, {x = end_pos}, "linear", function()
        enemy.scale_x = enemy.scale_x * -1
    end)
end

return Charge