local Shard, super = Class("p5/kristalguardian/bomb_base")

function Shard:init(x)
    super:init(self, x, "shard")
end

function Shard:explode()
    local soul = Game.battle.soul
    self.wave:spawnBullet("p5/kristalguardian/shard", self.x, self.y, Utils.angle(self, soul))
    super:explode(self)
end

return Shard