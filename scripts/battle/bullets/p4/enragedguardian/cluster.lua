local Cluster, super = Class(Bullet)

function Cluster:init(x, y)
    super:init(self, x, y, "battle/p5/kristalguardian/shard_cluster")
    self.layer = BATTLE_LAYERS["above_bullets"]
    self.rotation = Utils.random(math.pi*2)
    self.collider = CircleCollider(self, self.width/2, self.height/2, 14)
    self.double_damage = false
end

return Cluster