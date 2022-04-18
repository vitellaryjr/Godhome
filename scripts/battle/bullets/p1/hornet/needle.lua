local Needle, super = Class(Bullet)

function Needle:init(x, y, dir)
    super:init(self, x, y, "battle/p1/hornet/needle")
    self.rotation = dir
    self:setHitbox(9,2,12,3)

    self.lines = {}
end

function Needle:attack(dir, speed)
    self.physics = {
        speed = speed or 10,
        direction = dir
    }
    if #self.lines == 1 then
        local thread = table.remove(self.lines, 1)
        thread.collidable = false
        thread:fadeOutAndRemove(0.1)
    end
    table.insert(self.lines, self.wave:spawnBullet("p1/hornet/thread", self))
end

return Needle