local Blobs, super = Class(Wave)

function Blobs:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(160)
end

function Blobs:onStart()
    local arena = Game.battle.arena
    self.timer:every(1, function()
        for i=1,love.math.random(2,3) do
            local x = love.math.random(arena.left, arena.right)
            self:addChild(ParticleEmitter(x-8, 0, 16, 0, {
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
            self.timer:after(Utils.random(0.2), function()
                local blob = self:spawnBullet("common/sticky/falling", x, -50, 2, 0.5)
                blob.tp = 0.8
                blob:stopAt(love.math.random(arena.top, arena.bottom))
            end)
        end
    end)
    local nosk = Game.battle:getEnemyByID("p5/wingednosk")
    if nosk.health / nosk.max_health < 0.5 then
        local soul = Game.battle.soul
        self.timer:every(2, function()
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
        end)
    end
end

return Blobs