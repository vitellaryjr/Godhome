local Arc, super = Class("common/sticky/base")

function Arc:init(x, y, sx, sy, grav, time)
    super:init(self, x, y)
    self.physics = {
        speed_x = sx,
        speed_y = sy,
        gravity = grav,
        gravity_direction = math.pi/2,
    }
    self.time = time
end

function Arc:onAdd(parent)
    super:onAdd(self, parent)
    if self.time then
        self.wave.timer:after(self.time, function()
            self:stickToBG()
        end)
        local sx, sy, grav = self.physics.speed_x, self.physics.speed_y, self.physics.gravity
        local mx, my = self.x + (sx*self.time*30), self.y + (sy*self.time*30) + (0.5*grav*(self.time*30)^2)
        self:mark(mx, my + 8)
    else
        self.wave.timer:script(function(wait)
            while not Game.battle:checkSolidCollision(self) do
                wait()
            end
            while Game.battle:checkSolidCollision(self) do
                wait()
            end
            while true do
                for i,side in ipairs(Game.battle.arena.collider.colliders) do
                    if i ~= 1 and self:collidesWith(side) then
                        self:stickToSide(side)
                        break
                    end
                end
                wait()
            end
        end)
    end
end

return Arc