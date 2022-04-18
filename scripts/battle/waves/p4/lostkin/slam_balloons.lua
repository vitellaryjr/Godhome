local Slam, super = Class(Wave)

function Slam:init()
    super:init(self)
    self.time = 7
end

function Slam:onStart()
    local arena = Game.battle.arena
    self:addChild(ParticleEmitter(arena.x, arena.bottom, {
        layer = BATTLE_LAYERS["below_soul"],
        shape = "circle",
        color = {1, 0.2, 0},
        alpha = 0.5,
        scale = 1.2,
        scale_var = 0.2,
        angle = -math.pi/2,
        angle_var = 0.5,
        speed = 2.5,
        speed_var = 0.2,
        friction = 0.1,
        shrink = 0.1,
        shrink_after = 0.1,
        every = 0.2,
        amount = {1,2},
    }))
    self.timer:after(0.2, function()
        self.timer:everyInstant(0.7, function()
            self:addChild(ParticleEmitter(arena.x, arena.bottom, {
                layer = BATTLE_LAYERS["below_soul"],
                shape = "circle",
                color = {1, 0.2, 0},
                alpha = 0.5,
                scale = 0.8,
                scale_var = 0.2,
                angle = math.pi/2,
                angle_var = 0.5,
                speed = 2,
                speed_var = 0.5,
                friction = 0.1,
                shrink = 0.1,
                shrink_after = 0.1,
                amount = {1,2},
            }))
            for _=1,love.math.random(5,6) do
                local blob = self:spawnBullet("common/infection", arena.x, arena.bottom)
                blob.physics = {
                    speed_x = Utils.random(-4,4),
                    speed_y = Utils.random(5,6),
                    gravity = 0.5,
                    gravity_direction = -math.pi/2,
                }
            end
        end)
    end)
    self.timer:every(0.9, function()
        self:spawnBalloon()
    end)
end

function Slam:spawnBalloon()
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

return Slam