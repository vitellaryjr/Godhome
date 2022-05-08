local Nail, super = Class("nailbase")

function Nail:init(x, y)
    super:init(self, x, y, "battle/p1/nailmasters/nail")
    self.rotation = math.pi/2
    self.physics = {
        speed = 6,
        friction = 1,
        direction = -math.pi/2,
    }
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.1,
    }
    self.enemy = Game.battle:getEnemyBattler("p3/sly")

    self.spin_hb = CircleCollider(self, self.width/2, self.height/2, 22)
    self.spin_hb.collidable = false
    self.rect_hb = Hitbox(self,10,22,25,5)
    self.collider = ColliderGroup(self, {
        self.rect_hb,
        self.spin_hb,
    })

    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        wait(0.4)
        while true do
            self.physics = {
                speed = 20,
                direction = math.pi/2,
            }
            while not Game.battle:checkSolidCollision(self) do
                wait()
            end
            while Game.battle:checkSolidCollision(self) do
                wait()
            end
            wait(0.05)
            self:setParent(Game.battle.mask)
            while not Game.battle:checkSolidCollision(self) do
                wait()
            end
            self.physics.speed = 0
            wait(0.07)
            self.physics = {
                speed = 6,
                friction = 0.5,
                direction = -math.pi/2,
            }
            self:setParent(Game.battle)
            self.spinning = true
            self.graphics.spin = 0.2
            wait(0.1)
            self:setSprite("battle/p1/nailmasters/nail_spin_antic")
            wait(0.03)
            self:setSprite("battle/p1/nailmasters/nail_spin", 0.1, true)
            self.spin_hb.collidable = true
            self.rect_hb.collidable = false
            wait(0.2)
            self.spinning = false
            self.graphics.spin = 0
            self.spin_hb.collidable = false
            self.rect_hb.collidable = true

            local tx, ty = soul.x, arena.top
            local ta = Utils.angle(self.x, self.y, tx, ty)
            local angle = self.rotation + math.pi*2 + Utils.angleDiff(ta, self.rotation)
            timer:tween(0.2, self, {rotation = angle}, "out-quad")
            self:setSprite("battle/p1/nailmasters/nail_spin_antic")
            wait(0.05)
            self:setSprite("battle/p1/nailmasters/nail")
            wait(0.25)
            self.rotation = (self.rotation % (math.pi*2)) - (math.pi*2)
            timer:tween(0.3, self, {x = tx, y = ty, rotation = math.pi/2}, "out-sine")
            wait(0.4)
        end
    end)
end

function Nail:update()
    super:update(self)
    if self.spinning then
        self.graphics.spin = self.graphics.spin + 0.2*DTMULT
        self.rotation = self.rotation % (2*math.pi)
    end
end

function Nail:onDefeat()
    self.enemy.health = 9
end

function Nail:draw()
    super:draw(self)
    if DEBUG_RENDER and self.spin_hb.collidable then
        self.spin_hb:drawFor(self,1,0,0)
    end
end

return Nail