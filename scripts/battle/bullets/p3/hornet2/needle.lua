local Needle, super = Class(Bullet)

function Needle:init(x, y, dir, limit)
    super:init(self, x, y, "battle/p1/hornet/needle")
    self.rotation = dir
    self:setHitbox(9,2,12,3)

    self.lines = {}
    self.limit = limit or 1
end

function Needle:attack(dir, speed)
    self.physics = {
        speed = speed or 10,
        direction = dir or self.rotation,
    }
    if #self.lines == self.limit then
        self:removeLine()
    end
    table.insert(self.lines, self.wave:spawnBullet("p3/hornet2/thread", self))
end

function Needle:detach()
    -- set the needle var for the most recent thread to nil so it stops moving with it
    self.lines[#self.lines].needle = nil
end

function Needle:removeLine()
    local thread = table.remove(self.lines, 1)
    thread.collidable = false
    thread:fadeOutAndRemove(0.1)
end

return Needle