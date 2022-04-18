local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)
    self.time = 7
    self:setArenaSize((Game.battle.encounter.difficulty == 1) and 220 or 170)
end

function Charge:onStart()
    local arena = Game.battle.arena
    local angle = Utils.random(2*math.pi)
    local marmu = self:spawnBullet("p2/marmu/ball", arena.x + 55*math.cos(angle), arena.y + 55*math.sin(angle))
    self.timer:after(0.5, function()
        marmu:charge()
    end)
end

return Charge