local Jar, super = Class(Bullet)

function Jar:init(x, y)
    super:init(self, x, y, "battle/p3/collector/jar")
    self.rotation = Utils.random(math.pi*2)
    self.graphics.spin = 0.1*Utils.randomSign()
    self.collider = CircleCollider(self, 12,16, 4)
    self.physics.speed_y = 6
end

function Jar:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    if self:collidesWith(arena.collider.colliders[3]) then
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
            layer = BATTLE_LAYERS["below_bullets"],
            shape = "triangle",
            size = {6,12},
            angle = {{-math.pi/10,0}, {math.pi, math.pi*11/10}},
            speed = {2,8},
            gravity = 0.5,
            spin_dist = 0.1,
            spin_var = 0.1,
            fade = 0.2,
            fade_after = 0.1,
            amount = {6,8},
        }))
        local chance = Utils.clampMap(#self.wave.jar_enemies, 0,4, 1,0.2)
        if #self.wave.jar_enemies < 4 and love.math.random() < chance then
            local types = {}
            if Game.battle.encounter.difficulty > 1 then
                types = {"armor_vengefly", "sharp_baldur", "primal_aspid"}
            else
                types = {"vengefly", "baldur", "aspid"}
            end
            local type = Utils.pick(types)
            local enemy = self.wave:spawnBullet("p3/collector/"..type, self.x, self.y)
            table.insert(self.wave.jar_enemies, enemy)
        end
        self:remove()
    end
end

return Jar