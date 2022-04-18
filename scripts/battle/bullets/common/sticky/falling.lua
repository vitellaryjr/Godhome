local Fall, super = Class("common/sticky/base")

function Fall:init(x, y, start, grav, time)
    super:init(self, x, y)
    self.remove_offscreen = false
    self.physics = {
        speed = start,
        direction = math.pi/2,
        gravity = grav,
        gravity_direction = math.pi/2,
    }
    self.time = time
end

function Fall:onAdd(parent)
    super:onAdd(self, parent)
    if self.time then
        self.wave.timer:after(self.time, function()
            self:stickToBG()
        end)
        local mx, my = x, y + (self.physics.speed*self.time*30) + (0.5*grav*(self.time*30)^2)
        self:mark(mx, my + 8)
    else
        self.wave.timer:script(function(wait)
            local line = Game.battle.arena.collider.colliders[3]
            while not self:collidesWith(line) do
                wait()
            end
            self:stickToSide(line)
        end)
    end
end

function Fall:stopAt(y)
    local a,b,c = 0.5*self.physics.gravity, self.physics.speed, self.y - y
    local t1, t2 = (-b + math.sqrt(b^2 - 4*a*c))/(2*a), (-b - math.sqrt(b^2 - 4*a*c))/(2*a)
    self.wave.timer:after(math.max(t1, t2)/30, function()
        self:stickToBG()
    end)
    self:mark(self.x, y)
end

return Fall