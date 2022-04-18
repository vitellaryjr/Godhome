local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 6

    self.swords = {}
end

function Swords:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local shade = self:spawnBullet("p4/purevessel/dive", soul.x, arena.top - 50)
    self.timer:after(0.2, function()
        self.timer:script(function(wait)
            while true do
                shade:startDive()
                while #self.swords == 0 do
                    wait()
                end
                wait(0.4)
                for _,sword in ipairs(self.swords) do
                    sword:disappear()
                end
                self.swords = {}
                local nx, ny = soul.x, arena.top - 50
                self.timer:tween(0.3, shade, {x = nx, y = ny}, "in-out-quad")
                wait(0.3)
            end
        end)
    end)
end

function Swords:spawnSwords(sx)
    local arena = Game.battle.arena
    for i=-3,3 do
        local x = sx + i*38
        local glow = self:spawnSpriteTo(Game.battle.mask, "battle/p4/purevessel/soul_gradient", x, arena.bottom)
        glow:setOrigin(0, 0.5)
        glow.rotation = -math.pi/2
        glow.alpha = 0.6
        self.timer:after(0.25, function()
            glow:fadeOutAndRemove(0.05)
            table.insert(self.swords, self:spawnBulletTo(Game.battle.mask, "p4/purevessel/sword", x, arena.bottom))
        end)
    end
end

return Swords