local Oblobble, super = Class("nailbase")

function Oblobble:init(x, y, angy)
    super:init(self, x, y, "battle/p2/oblobbles/idle")
    self.sprite:play(0.2, true)
    self.sprite:setScaleOrigin(0.5, 0.5)

    self.collider = CircleCollider(self, self.width/2, self.height/2, 12)

    local dir = Utils.randomSign()
    self.sprite.scale_x = dir
    local angle = Utils.random(-math.pi/3, math.pi/3)
    self.speed = angy and 5 or 3
    self.physics = {
        speed_x = math.cos(angle)*self.speed*dir,
        speed_y = math.sin(angle)*self.speed,
    }

    self.angry = angy
    self.firing = false

    self.timer = Timer()
    self:addChild(self.timer)
end

function Oblobble:update()
    super:update(self)
    if not self.firing then
        local arena = Game.battle.arena
        for _,line in ipairs(arena.collider.colliders) do
            if self:collidesWith(line) then
                local angle = Utils.angle(line.x, line.y, line.x2, line.y2)
                local dir = arena.clockwise and -1 or 1
                local base = angle + dir*math.pi/2
                local new_angle = Utils.random(base - math.pi/3, base + math.pi/3)
                self.physics = {
                    speed_x = math.cos(new_angle)*self.speed,
                    speed_y = math.sin(new_angle)*self.speed,
                }
                self.sprite.scale_x = Utils.sign(self.physics.speed_x)
            end
        end
        for _,other in ipairs(Game.stage:getObjects(Registry.getBullet("p2/oblobbles/oblobble"))) do
            if other ~= self and self:collidesWith(other) then
                local angle = Utils.angle(other.x, other.y, self.x, self.y)
                local dx, dy = other.x-self.x, other.y-self.y
                local new_angle = Utils.random(0, math.pi/3)
                local sx, sy = Utils.randomSign(), Utils.randomSign()
                if math.abs(dx) > math.abs(dy) then
                    if self.x < other.x then
                        sx = -1
                    else
                        sx = 1
                    end
                else
                    if self.y < other.y then
                        sy = -1
                    else
                        sy = 1
                    end
                end
                self:setPosition(other.x + math.cos(angle)*50, other.y + math.sin(angle)*50)
                self.physics = {
                    speed_x = math.cos(new_angle)*self.speed*sx,
                    speed_y = math.sin(new_angle)*self.speed*sy,
                }
                self.sprite.scale_x = sx
            end
        end
        self:setPosition(
            Utils.clamp(self.x, arena.left + self.collider.radius+1, arena.right - self.collider.radius-1),
            Utils.clamp(self.y, arena.top + self.collider.radius+1, arena.bottom - self.collider.radius-1)
        )
    end
end

function Oblobble:fire()
    local old_x, old_y = self.physics.speed_x, self.physics.speed_y
    self.physics = {}
    self.sprite:setAnimation{"battle/p2/oblobbles/spit", 0.15, true}
    local angle = Utils.random(math.pi/2)
    local incr = Utils.random(math.pi/6, math.pi/4)
    if self.angry then
        self.timer:every(0.3, function()
            for i=1,4 do
                local blob = self.wave:spawnBullet("common/infection", self.x, self.y)
                blob.collider = CircleCollider(blob, blob.width/2,blob.height/2, 1)
                blob.physics = {
                    speed = 7,
                    direction = angle + i*math.pi/2,
                    gravity = 0.05,
                    gravity_direction = math.pi/2,
                }
                blob.layer = self.layer - 1
                blob.remove_offscreen = true
            end
            angle = angle + incr
        end, 8)
        self.timer:after(3, function()
            self.sprite:setAnimation{"battle/p2/oblobbles/idle", 0.2, true}
            self.physics = {
                speed_x = old_x,
                speed_y = old_y,
            }
        end)
    else
        self.timer:every(0.5, function()
            for i=1,4 do
                local blob = self.wave:spawnBullet("common/infection", self.x, self.y)
                blob.collider = CircleCollider(blob, blob.width/2,blob.height/2, 1)
                blob.physics = {
                    speed = 6,
                    direction = angle + i*math.pi/2,
                    gravity = 0.05,
                    gravity_direction = math.pi/2,
                }
                blob.layer = self.layer + 1
                blob.remove_offscreen = true
            end
            angle = angle + incr
        end, 6)
        self.timer:after(3.5, function()
            self.sprite:setAnimation{"battle/p2/oblobbles/idle", 0.2, true}
            self.physics = {
                speed_x = old_x,
                speed_y = old_y,
            }
        end)
    end
end

function Oblobble:onDefeat()
    super:onDefeat(self)
    local body = self.wave:spawnSprite("battle/p2/oblobbles/spit", self.x, self.y)
    body.scale_y = -2
    body.physics = {
        speed_x = 2*Utils.randomSign(),
        speed_y = -3,
        gravity = 0.8,
        gravity_direction = math.pi/2,
    }
    body.color = self.color
    body.alpha = 0.5
    body:fadeOutAndRemove(0.02)
    local oblobbles = Game.stage:getObjects(Registry.getBullet("p2/oblobbles/oblobble"))
    if #oblobbles > 1 then
        for _,o in ipairs(oblobbles) do
            o.angry = true
            o.speed = 5
            if o.physics.speed_x then
                o.physics.speed_x = o.physics.speed_x * 5/3
                o.physics.speed_y = o.physics.speed_y * 5/3
            end
        end
    else
        self.wave.finished = true
    end
end

return Oblobble