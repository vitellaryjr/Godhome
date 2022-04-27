local SpawnZote, super = Class(Bullet)

function SpawnZote:init(x, y)
    super:init(self, x, y, "battle/p3/greyprince/spawn_zote")
    self.layer = BATTLE_LAYERS["below_soul"]
    self.graphics.spin = 0.2
    self.physics.speed_y = 8
    self.collidable = false
    self.wall_hb = Hitbox(self, 0,0, 12,12)
end

function SpawnZote:update()
    super:update(self)
    if self.wall_hb:collidesWith(Game.battle.arena.collider.colliders[3]) then
        local zote
        if love.math.random() < 0.5 then
            zote = self.wave:spawnBullet("p3/greyprince/zotefly", self.x, self.y)
        else
            zote = self.wave:spawnBullet("p3/greyprince/zotehopper", self.x)
        end
        table.insert(self.wave.enemies, zote)
        self:remove()
    end
end

return SpawnZote