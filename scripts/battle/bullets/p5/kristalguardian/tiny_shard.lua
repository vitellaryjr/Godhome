local Shard, super = Class(Bullet)

function Shard:init(x, y)
    super:init(self, x, y, "battle/p5/kristalguardian/tiny_shard_"..Utils.pick{"a","b"})
    self.collider = CircleCollider(self, self.width/2, self.height/2, 1)
    self.rotation = Utils.random(math.pi*2)
end

return Shard