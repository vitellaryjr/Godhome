local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 6
end

function Arcs:onStart()
    self.timer:after(0.2, function()
        self:spawnBlob()
        self.timer:every(1, function()
            self:spawnBlob()
        end)
    end)
end

function Arcs:spawnBlob()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local blob = self:spawnBulletTo(Game.battle.mask, "common/infection", soul.x, arena.top-8)
    blob.physics = {
        speed = 0,
        gravity = 0.3,
        gravity_direction = math.pi/2,
    }
    self.timer:script(function(wait)
        while not blob:collidesWith(arena.collider.colliders[3]) do
            wait()
        end
        for i=1,4 do
            local new_blob = self:spawnBullet("common/infection", blob.x, arena.bottom)
            new_blob.physics = {
                speed_x = (i-2.5)*2,
                speed_y = 6,
                gravity = 0.5,
                gravity_direction = -math.pi/2
            }
        end
        self:addChild(ParticleEmitter(blob.x, arena.bottom, {
            layer = BATTLE_LAYERS["below_soul"],
            shape = "circle",
            color = {1, 0.4, 0},
            alpha = 0.5,
            scale = 0.8,
            scale_var = 0.2,
            angle = math.pi/2,
            angle_var = math.pi/3,
            speed = 3,
            speed_var = 0.5,
            friction = 0.1,
            shrink = 0.1,
            shrink_after = 0.1,
            amount = {5,6},
        }))
        blob:remove()
    end)
end

return Arcs