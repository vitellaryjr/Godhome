local ArenaThorns, super = Class(Bullet)

function ArenaThorns:init(arena)
    super:init(self, 0,0)
    self:setOrigin(0, 0)
    self:setScale(1, 1)

    self.layer = BATTLE_LAYERS["arena"] + 10
    self.tp = 0

    local lines = {}
    local arena_points = Utils.getPolygonOffset(arena.shape, -1)
    local sx, sy = arena:getLeft(), arena:getTop()
    for i,p in ipairs(arena_points) do
        local np = arena_points[(i % #arena_points) + 1]
        local line = LineCollider(self, p[1]+sx, p[2]+sy, np[1]+sx, np[2]+sy)
        table.insert(lines, line)
    end
    self.collider = ColliderGroup(self, lines)

    for i,p in ipairs(arena.shape) do
        local np = arena.shape[(i % #arena.shape) + 1]
        local dist = Vector.dist(p[1], p[2], np[1], np[2])
        local size = dist/32
        local amt = Utils.round(size)
        local scale = size/amt
        for i=0,amt-1 do
            local x, y = (np[1] - p[1])*i/amt + p[1] + sx, (np[2] - p[2])*i/amt + p[2] + sy
            local sprite = Sprite("battle/common/thorns", x, y)
            sprite:setOrigin(0, 0.5)
            sprite:setScale(2*scale, 2)
            sprite.rotation = Utils.angle(p[1], p[2], np[1], np[2])
            sprite.color = arena.color
            self:addChild(sprite)
        end
    end
end

return ArenaThorns