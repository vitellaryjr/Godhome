local Nail, super = Class("nailbase")

function Nail:init(x, y)
    super:init(self, x, y, "battle/p1/nailmasters/nail")
    self.graphics.spin = 0.4
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
        self.physics = {
            speed_y = 10,
        }
        wait(0.69)
        self.physics = {}
        self:spin()
        wait(0.5)
        while true do
            local ta, tx, ty = 0, 0, 0
            local was_spinning = self.spinning
            local charge = false
            if not was_spinning and love.math.random() < 0.3 then -- target player
                ta = Utils.angle(self, soul)
                local length = math.min(Vector.len(self.x, self.y, soul.x, soul.y), 140)
                tx, ty = self.x + length*math.cos(ta), self.y + length*math.sin(ta)
                charge = true
            else
                while true do
                    ta = Utils.random(math.pi*2)
                    local length = 140
                    tx, ty = self.x + length*math.cos(ta), self.y + length*math.sin(ta)
                    if tx > arena.left and tx < arena.right and ty > arena.top and ty < arena.bottom then
                        break
                    end
                end
                charge = not was_spinning and love.math.random() < 0.5
            end
            if was_spinning then
                self:unspin()
            end
            local angle = self.rotation + Utils.angleDiff(ta, self.rotation)
            timer:tween(0.3, self, {rotation = angle}, "out-quad")
            wait(0.4)
            if charge then
                self.physics = {
                    speed = 6,
                    friction = 1,
                    direction = self.rotation + math.pi,
                }
                wait(0.3)
                timer:tween(0.4, self, {x = tx, y = ty}, "out-sine")
                self:spin()
                wait(0.7)
            else
                timer:tween(0.4, self, {x = tx, y = ty}, "out-sine")
                wait(0.5)
            end
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
    super:onDefeat(self)
    self.wave.finished = true
end

function Nail:spin()
    self.spinning = true
    self.wave.timer:script(function(wait)
        wait(0.05)
        self:setSprite("battle/p1/nailmasters/nail_spin_antic")
        wait(0.05)
        self:setSprite("battle/p1/nailmasters/nail_spin", 0.1, true)
        self.spin_hb.collidable = true
        self.rect_hb.collidable = false
    end)
end

function Nail:unspin()
    self.spinning = false
    self.spin_hb.collidable = false
    self.rect_hb.collidable = true
    self.graphics.spin = 0
    self:setSprite("battle/p1/nailmasters/nail_spin_antic")
    self.wave.timer:after(0.05, function()
        self:setSprite("battle/p1/nailmasters/nail")
    end)
end

return Nail