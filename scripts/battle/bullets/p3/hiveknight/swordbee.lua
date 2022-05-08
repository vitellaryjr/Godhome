local Bee, super = Class("nailbase")

function Bee:init(x, y, dir)
    super:init(self, x, y, "battle/p3/hiveknight/sword_bee")
    self.sprite:play(0.2, true)
    self.collider = CircleCollider(self, 13, 10, 4)
    self.enemy = Game.battle:getEnemyBattler("p3/hiveknight")

    self.rotation = dir
end

function Bee:charge(back_up)
    back_up = back_up ~= false
    local soul = Game.battle.soul
    local angle_to = self.rotation - Utils.angleDiff(self.rotation, Utils.angle(self.x, self.y, soul.x, soul.y))
    self.wave.timer:tween(0.2, self, {rotation = angle_to})
    if back_up then
        self.physics = {
            speed = -6,
            friction = 1,
            match_rotation = true,
        }
    end
    self.wave.timer:after(0.3, function()
        self.physics = {
            speed = 10,
            direction = angle_to,
            match_rotation = false,
        }
    end)
    self.wave.timer:after(0.6, function()
        self.physics.friction = 2
        angle_to = self.rotation - Utils.angleDiff(self.rotation, Utils.angle(self.x, self.y, soul.x, soul.y))
        self.wave.timer:tween(0.2, self, {rotation = angle_to})
    end)
end

function Bee:teleport()
    local soul = Game.battle.soul
    local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
    local angle_to = self.rotation - Utils.angleDiff(self.rotation, angle + math.pi/2*Utils.randomSign())
    self.wave.timer:tween(0.1, self, {rotation = angle_to})
    self.physics = {
        speed = 10,
        direction = angle_to,
        match_rotation = false,
    }
    self.graphics = {
        fade = 0.2,
        fade_to = 0,
        grow_x = 0.2,
        grow_y = -0.2,
        remove_shrunk = true,
    }

    self.wave.timer:after(0.1, function()
        local x, y = soul.x + 40*math.cos(angle), soul.y + 40*math.sin(angle)
        local nb = self.wave:spawnBullet("p3/hiveknight/swordbee", x, y, angle_to)
        self.wave.b = nb
        nb.alpha = 0
        nb:setScale(4,0)
        nb.graphics = {
            fade = 0.2,
            fade_to = 1,
            remove_shrunk = false,
        }
        self.wave.timer:tween(0.2, nb, {scale_x = 2, scale_y = 2})
        nb.physics = {
            speed = 10,
            friction = 1,
            direction = angle_to,
            match_rotation = false,
        }
        self.wave.timer:after(0.2, function()
            nb:charge(false)
        end)
    end)
end

return Bee