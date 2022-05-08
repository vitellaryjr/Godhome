local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)

    self.time = 8
    self:setArenaSize(150)
end

function Charge:onStart()
    local arena = Game.battle.arena

    local enemy = Game.battle:getEnemyBattler("p1/vengeflyking")
    enemy.sprite:setAnimation("charge")
    self:spawnBulletTo(enemy.sprite, "p1/vengeflyking/chargeking", enemy)
    self.orig_data = {x = enemy.x, y = enemy.y, layer = enemy.layer}
    enemy.layer = BATTLE_LAYERS["bullets"]

    self.timer:tween(0.7, enemy, {y = arena.top + 20}, "in-out-sine")
    self.timer:after(1.5, function()
        self:charge("left")
    end)
    self.timer:every(3, function()
        self:charge("right")
        self.timer:after(1.5, function()
            self:charge("left")
        end)
    end)
end

function Charge:onEnd()
    local enemy = Game.battle:getEnemyBattler("p1/vengeflyking") or Mod:getDeadEnemyByID("p1/vengeflyking")
    enemy.sprite:setAnimation("idle")
    enemy.scale_x = 2
    local x, y = self.orig_data.x, self.orig_data.y
    Game.battle.timer:tween(0.5, enemy, {x=x, y=y}, "out-sine", function()
        enemy.layer = self.orig_data.layer
    end)
    super:onEnd(self)
end

function Charge:charge(dir)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local enemy = Game.battle:getEnemyBattler("p1/vengeflyking")

    local end_pos = (dir == "left") and (arena.left - 100) or (arena.right + 100)
    local target_y = soul.y + 30
    self.timer:tween(0.5, enemy, {y = target_y}, "out-sine", function()
        self.timer:tween(0.5, enemy, {y = arena.top + 20}, "in-sine")
    end)
    self.timer:tween(1, enemy, {x = end_pos}, "linear", function()
        enemy.scale_x = enemy.scale_x * -1
    end)
end

return Charge