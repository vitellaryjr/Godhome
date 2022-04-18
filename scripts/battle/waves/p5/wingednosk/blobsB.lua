local Blobs, super = Class(Wave)

function Blobs:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Blobs:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    for _=1,love.math.random(3,4) do
        local blob = self:spawnBullet("common/sticky/base", love.math.random(arena.left, arena.right), arena.top)
        blob:stickToSide(arena.collider.colliders[1])
    end
    self.timer:every(1, function()
        local side = Utils.sign(arena.x - soul.x)
        if side == 0 then side = Utils.randomSign() end
        local x, y = arena.x + arena.width*side, arena.bottom - 40
        for _=1,4 do
            local sx, sy = Utils.random(-6,-8)*side, Utils.random(-2,-10)
            local blob = self:spawnBullet("common/sticky/arc", x, y, sx, sy, 0.5)
            blob.tp = 0.8
        end
    end)
    local nosk = Game.battle:getEnemyByID("p5/wingednosk")
    if nosk.health / nosk.max_health < 0.5 then
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