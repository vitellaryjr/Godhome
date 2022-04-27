local Fireball, super = Class(Bullet)

function Fireball:init(x, y, speed, dir, after)
    super:init(self, x, y, "battle/p3/grimm/fireball")
    self.sprite:play(0.1, true)
    self.layer = BATTLE_LAYERS["below_bullets"]
    self:setRotationOriginExact(10, 6)
    self.rotation = dir
    self.collider = CircleCollider(self, 10, 6, 4)
    self.tp = 0.4

    self.physics = {
        speed = speed,
        match_rotation = true,
    }
    self.after = after
end

function Fireball:onAdd(parent)
    super:onAdd(self, parent)
    if self.after then
        self.wave.timer:after(self.after, function()
            self.wave.timer:tween(0.2, self.physics, {speed = 4})
            if math.cos(self.rotation) < 0 then
                self.wave.timer:tween(0.2, self, {rotation = math.pi})
            else
                self.wave.timer:tween(0.2, self, {rotation = 0})
            end
        end)
    end
end

function Fireball:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.x < arena.left - 10 or self.x > arena.right + 10 or self.y > arena.bottom + 10 then
        self:remove()
    end
end

return Fireball