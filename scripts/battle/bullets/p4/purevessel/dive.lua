local Dive, super = Class("nailbase")

function Dive:init(x, y)
    super:init(self, x, y, "battle/p4/purevessel/shade_teleport")
    self.enemy = Game.battle:getEnemyBattler("p4/purevessel")
    self.enemy_tp = 0
    self:ball()
end

function Dive:update()
    super:update(self)
    local arena = Game.battle.arena
    if self:collidesWith(arena.collider.colliders[3]) then
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
            path = "battle/p4/purevessel",
            shape = "void_particle",
            rotation = {0, 2*math.pi},
            spin_var = 0.5,
            size = {7,9},
            angles = -1/8*math.pi,
            angles_var = 0.2,
            physics = {
                speed = 4,
                speed_var = 1,
                friction = 0.2,
            },
            shrink = 0.1,
            shrink_after = 0.1,
            amount = love.math.random(2,3),
        }))
        Game.battle:addChild(ParticleEmitter(self.x, arena.bottom, {
            path = "battle/p4/purevessel",
            shape = "void_particle",
            rotation = {0, 2*math.pi},
            spin_var = 0.5,
            size = {7,9},
            angles = -7/8*math.pi,
            angles_var = 0.2,
            physics = {
                speed = 4,
                speed_var = 1,
                friction = 0.2,
            },
            shrink = 0.1,
            shrink_after = 0.1,
            amount = love.math.random(2,3),
        }))
        Game.battle.shake = 4
        self.wave:spawnSwords(self.x)
        self:ball()
    end
end

function Dive:ball()
    self:setSprite("battle/p4/purevessel/shade_teleport")
    self.collider = CircleCollider(self, self.width/2, self.height/2, 2)
    self:setLayer(BATTLE_LAYERS["below_bullets"])
    self:move(0, 20)
    self.physics = {}
    self.graphics.spin = 0.2
    self.collidable = false
end

function Dive:startDive()
    self.rotation = 0
    self.graphics.spin = 0
    self:setSprite("battle/p4/purevessel/shade_dive", 0.1, true)
    self:setHitbox(5, 9, 10, 28)
    self:setLayer(BATTLE_LAYERS["bullets"])
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite.scale_x = 0
    self.wave.timer:tween(0.2, self.sprite, {scale_x = 1})
    self.physics = {
        speed_y = -4,
        friction = 0.5,
    }
    self.collidable = true
    self.wave.timer:after(0.3, function() self.physics = {speed_y = 18} end)
end

return Dive