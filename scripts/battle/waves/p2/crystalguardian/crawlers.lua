local Crawlers, super = Class(Wave)

function Crawlers:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160)
end

function Crawlers:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local dir = Utils.random(0, 2*math.pi, math.pi/2)
    local facing = Utils.randomSign()
    for i=-5,5 do
        local x, y = arena.x - (arena.width/2)*math.cos(dir), arena.y - (arena.height/2)*math.sin(dir)
        local is_hori = x == arena.x
        if is_hori then
            x = arena.x + i*100
        else
            y = arena.y + i*100
        end
        local crystal = self:spawnBulletTo(Game.battle.mask, "common/crystal/crawler", x, y, dir, facing)
        if (is_hori and math.abs(x - soul.x) > 120 and love.math.random() < 0.25)
        or (not is_hori and math.abs(y - soul.y) > 120 and love.math.random() < 0.25) then
            crystal:fire(1, true)
            crystal:every(3, 0.5)
        else
            self.timer:after(Utils.random(3), function()
                crystal:fire(1)
                crystal:every(3, 0.2)
            end)
        end
    end
end

return Crawlers