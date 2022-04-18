local Cluster, super = Class("nailbase")

function Cluster:init(x, y)
    super:init(self, x, y, "battle/p5/kristalguardian/shard_cluster")
    self.layer = BATTLE_LAYERS["below_bullets"]
    self.rotation = Utils.random(math.pi*2)
    self.collider = CircleCollider(self, self.width/2, self.height/2, 12)
    self.health = 1
    self.nail_tp = 0.8
    self.hit_sfx = "crystal_break_"..Utils.pick{"a","b"}
    self.hit_volume = 0.7
end

function Cluster:onDefeat()
    self.wave:addChild(ParticleEmitter(self.x, self.y, {
        shape = "triangle",
        color = {1,1,1},
        alpha = 0.5,
        size = {10,14},
        speed = 4,
        speed_var = 1,
        friction = 0.1,
        shrink = 0.1,
        shrink_after = 0.1,
        amount = {3,4},
    }))
    super:onDefeat(self)
end

return Cluster