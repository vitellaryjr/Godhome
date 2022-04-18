local Blobs, super = Class(Wave)

function Blobs:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Blobs:onStart()
    local arena = Game.battle.arena
    for _=1,love.math.random(3,4) do
        local blob = self:spawnBullet("common/sticky/base", love.math.random(arena.left, arena.right), arena.top)
        blob:stickToSide(arena.collider.colliders[1])
    end
    local side = Utils.randomSign()
    self.timer:every(1.5, function()
        local x, y = arena.x + arena.width*side, arena.bottom + 20
        for _=1,3 do
            local sx, sy = Utils.random(-4,-6)*side, Utils.random(-5,-14)
            local time = (love.math.random() < 0.3) and Utils.random(0.3, 1) or nil
            self:spawnBullet("common/sticky/arc", x, y, sx, sy, 0.5, time)
        end
        side = side*-1
    end)
end

return Blobs