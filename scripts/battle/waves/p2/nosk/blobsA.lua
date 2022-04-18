local Blobs, super = Class(Wave)

function Blobs:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(160)
end

function Blobs:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:every(0.8, function()
        Game.battle:addChild(ParticleEmitter(soul.x-8, 0, 16, 0, {
            layer = BATTLE_LAYERS["below_soul"],
            shape = "circle",
            color = {1, 0.2, 0},
            alpha = 0.5,
            scale = 0.8,
            scale_var = 0.2,
            angle = math.pi/2,
            speed = 2,
            speed_var = 0.5,
            friction = 0.1,
            shrink = 0.1,
            shrink_after = 0.1,
            every = 0.1,
            amount = {1,2},
            time = 0.4,
        }))
        local blob = self:spawnBullet("common/sticky/falling", soul.x, -50, 2, 0.5)
        if love.math.random() < 0.7 then
            blob:stopAt(soul.y)
        end
    end)
end

return Blobs