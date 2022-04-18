local Shard, super = Class(Bullet)

function Shard:init(x, y, dir)
    super:init(self, x, y, "battle/p5/kristalguardian/shard")
    self.rotation = dir
    self.physics = {
        speed = 10,
        direction = dir,
    }
end

function Shard:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        while not Game.battle:checkSolidCollision(self) do
            wait()
        end
        while Game.battle:checkSolidCollision(self) do
            wait()
        end
        while not Game.battle:checkSolidCollision(self) do
            wait()
        end
        self.wave:spawnBullet("p5/kristalguardian/shard_cluster", self.x, self.y)
        self:remove()
    end)
end

return Shard