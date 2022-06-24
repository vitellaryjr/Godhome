local SpawnZote, super = Class(Bullet)

function SpawnZote:init(x, y, type)
    super:init(self, x, y, "battle/ordeal/spawn_zote")
    self.layer = BATTLE_LAYERS["below_soul"]
    self.graphics.spin = 0.2
    self.physics.speed_y = 8
    self.collider.collidable = false
    self.wall_hb = Hitbox(self, 0,0, 12,12)

    self.type = type
end

function SpawnZote:update()
    super:update(self)
    if self.wall_hb:collidesWith(Game.battle.arena.collider.colliders[3]) then
        local zote = self.wave:spawnBullet("ordeal/"..self.type, self.x, self.y)
        zote.zote_type = self.type
        table.insert(self.wave.zotes, zote)
        if not self.wave.zotes_by_type[self.type] then
            self.wave.zotes_by_type[self.type] = {}
        end
        table.insert(self.wave.zotes_by_type[self.type], zote)
        self:remove()
    end
end

return SpawnZote