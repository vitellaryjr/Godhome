local Nail, super = Class(Bullet)

function Nail:init(x, y, dir)
    super:init(self, x, y, "battle/p1/nailmasters/nail")
    self.rotation = dir
    self.physics = {
        speed = 6,
        friction = 1,
        direction = dir+math.pi,
    }
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.1,
    }

    self.spin_hb = CircleCollider(self, self.width/2, self.height/2, 22)
    self.spin_hb.collidable = false
    self.rect_hb = Hitbox(self,10,22,25,5)
    self.collider = ColliderGroup(self, {
        self.rect_hb,
        self.spin_hb,
    })

    self.init_dir = dir
    local timer = Timer()
    self:addChild(timer)
    timer:after(0.5, function()
        self.physics = {
            speed = 14,
            direction = dir,
        }
        timer:script(function(wait)
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
            wait(0.2)
            self.physics = {
                speed = 6,
                friction = 0.5,
                direction = dir+math.pi,
            }
            wait(0.1)
            self:setParent(Game.battle)
            self.spinning = true
            self.graphics.spin = 0.2
            wait(0.1)
            self:setSprite("battle/p1/nailmasters/nail_spin_antic")
            wait(0.05)
            self:setSprite("battle/p1/nailmasters/nail_spin", 0.1, true)
            self.spin_hb.collidable = true
            self.rect_hb.collidable = false
            wait(0.5)
            self.spinning = false
            self.spin_hb.collidable = false
            self.rect_hb.collidable = true
            self:setSprite("battle/p1/nailmasters/nail_spin_antic")
            wait(0.05)
            self:setSprite("battle/p1/nailmasters/nail")
            self.physics = {
                speed = 4,
                friction = -0.2,
                direction = dir,
            }
            wait(0.5)
            self:fadeOutAndRemove(0.1)
        end)
    end)
end

function Nail:update()
    super:update(self)
    if self.spinning then
        self.graphics.spin = self.graphics.spin + 0.1*DTMULT
        self.rotation = self.rotation % (2*math.pi)
    elseif self.graphics.spin then
        self.graphics.spin = Utils.approach(self.graphics.spin, 0.2, 0.3*DTMULT)
    end
end

function Nail:draw()
    super:draw(self)
    if DEBUG_RENDER and self.spin_hb.collidable then
        self.spin_hb:drawFor(self,1,0,0)
    end
end

return Nail