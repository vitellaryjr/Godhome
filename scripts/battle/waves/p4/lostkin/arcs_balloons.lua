local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 7
end

function Arcs:onStart()
    self.timer:after(0.2, function()
        self.timer:everyInstant(1.8, function()
            self:spawnBlob()
        end)
    end)
    self.timer:every(1.2, function()
        self:spawnBalloon()
    end)
end

function Arcs:spawnBlob()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local blob = self:spawnBulletTo(Game.battle.mask, "common/infection", soul.x, arena.top-8)
    blob.physics = {
        speed = 0,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    self.timer:script(function(wait)
        while not blob:collidesWith(arena.collider.colliders[3]) do
            wait()
        end
        for i=1,6 do
            local new_blob = self:spawnBullet("common/infection", blob.x, arena.bottom)
            new_blob.physics = {
                speed_x = (i-3.5)*1.5,
                speed_y = 6,
                gravity = 0.5,
                gravity_direction = -math.pi/2
            }
        end
        self:addChild(ParticleEmitter(blob.x, arena.bottom, {
            layer = BATTLE_LAYERS["below_soul"],
            shape = "circle",
            color = {1, 0.2, 0},
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

function Arcs:spawnBalloon()
    local soul = Game.battle.soul
    local angle, dist = Utils.random(math.pi*2), love.math.random(50, 75)
    local x, y = soul.x + dist*math.cos(angle), soul.y + dist*math.sin(angle)
    local ps = ParticleAbsorber(x, y, {
        layer = BATTLE_LAYERS["above_arena"],
        shape = "circle",
        color = {1, 0.75, 0.4},
        size = {6,8},
        dist = {16,32},
        shrink = 0.05,
        shrink_after = {0.2,0.3},
        move_time = 0.5,
        amount = {1,2},
        every = 0.1,
    })
    self:addChild(ps)
    self.timer:after(0.4, function()
        ps:remove()
        self:spawnBullet("common/balloon", x, y)
    end)
end

return Arcs