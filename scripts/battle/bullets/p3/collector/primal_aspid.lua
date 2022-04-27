local Aspid, super = Class("nailbase")

function Aspid:init(x, y, enemy)
    super:init(self, x, y, "battle/p3/collector/primal_aspid")
    self.sprite:play(0.2, true)
    self.collider = CircleCollider(self, 8,9, 2)
    if enemy then
        self.enemy = enemy
    else
        self.health = 60
    end
    self.knockback = 4

    local soul = Game.battle.soul
    if soul.x > x then
        self.scale_x = -2
    end
    self.physics = {
        speed = 0,
        direction = Utils.angle(soul.x, soul.y, self.x, self.y),
    }

    self.speed_sine = 0
    self.y_sine = 0
    self.slowdown = 1

    self.timer = Timer()
    self:addChild(self.timer)

    self.type = "primal_aspid"
end

function Aspid:onAdd(parent)
    super:onAdd(self, parent)
    self.timer:after(Utils.random(1, 3), function()
        self.timer:everyInstant(3, function()
            self.sprite:setAnimation{"battle/p3/collector/primal_aspid_spit", 0.15, false}
            self.timer:tween(0.3, self, {slowdown = 0})
            self.timer:after(0.5, function()
                self:setSprite("battle/p3/collector/primal_aspid", 0.2, true)
                self.timer:tween(0.3, self, {slowdown = 1})
                local soul = Game.battle.soul
                local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
                for i=-1,1 do
                    local blob = self.wave:spawnBullet("common/infection", self.x, self.y)
                    blob.layer = self.layer - 1
                    blob.physics = {
                        speed = 6,
                        direction = angle + i*0.4,
                        gravity = 0.03,
                        gravity_direction = math.pi/2,
                    }
                end
            end)
        end)
    end)
end

function Aspid:update()
    super:update(self)
    local arena = Game.battle.arena
    local soul = Game.battle.soul

    if soul.x < self.x then
        self.scale_x = 2
    else
        self.scale_x = -2
    end

    self.speed_sine = self.speed_sine + DT*self.slowdown
    self.y_sine = self.y_sine + DT

    local speed = (1 + 1*((math.sin(self.speed_sine*4)+1)/2)) * self.slowdown
    if math.abs(self.x - soul.x) < 60 then
        self.physics.speed = Utils.approach(self.physics.speed, speed, 0.2*DTMULT)
        self.physics.friction = 0
        self.physics.direction = Utils.angle(soul.x, soul.y + 60, self.x, self.y)
    elseif math.abs(self.x - soul.x) > 100 then
        self.physics.speed = Utils.approach(self.physics.speed, speed, 0.2*DTMULT)
        self.physics.friction = 0
        self.physics.direction = Utils.angle(self.x, self.y, soul.x, soul.y - 60)
    else
        self.physics.friction = 0.1
    end

    self:move(0, 1*math.sin(self.y_sine*5)*self.slowdown*DTMULT)

    self:setPosition(
        Utils.clamp(self.x, arena.left+self.collider.radius*2+1, arena.right-self.collider.radius*2-1),
        Utils.clamp(self.y, arena.top+self.collider.radius*2+1, arena.bottom-self.collider.radius*2-1)
    )
end

function Aspid:onDefeat()
    Utils.removeFromTable(self.wave.jar_enemies, self)
    if self.enemy then
        self.enemy:onDefeat()
    end
    super:onDefeat(self)
end

return Aspid