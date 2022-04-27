local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = 6
    self:setArenaSize(180)
end

function Chase:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:every(1, function()
        local angle = Utils.random(2*math.pi)
        local x, y = soul.x + 150*math.cos(angle), soul.y + 150*math.sin(angle)
        local bullet = self:spawnBullet("common/soulorb", x, y, 2, angle+math.pi)
        bullet.inside = 0
    end)
end

function Chase:update()
    super:update(self)
    local arena = Game.battle.arena
    for _,bullet in ipairs(self.bullets) do
        if bullet.inside == 0 and bullet:collidesWith(arena.area_collider) then
            bullet.inside = 1
        elseif bullet.inside == 1 and not bullet:collidesWith(arena) then
            bullet.inside = 2
        elseif bullet.inside == 2 and bullet:collidesWith(arena) then
            bullet:destroy()
        end
    end
end

return Chase