local Pickaxe, super = Class("p5/kristalguardian/bomb_base")

function Pickaxe:init(x)
    super:init(self, x, "pickaxe")
end

function Pickaxe:explode()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local sx = Utils.sign(arena.x - self.x)*Utils.random(4,10)
    self.wave:spawnBullet("p5/kristalguardian/pickaxe", self.x, self.y, sx, Utils.random(-7,-14))
    super:explode(self)
end

return Pickaxe