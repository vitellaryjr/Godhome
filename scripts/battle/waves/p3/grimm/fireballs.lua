local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 6
end

function Arcs:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:after(0.2, function()
        self.timer:everyInstant(1, function()
            for i=-2,2 do
                local sx = i*4
                local fire = self:spawnBullet("p3/grimm/arcFireball", soul.x, arena.top, sx)
                fire.layer = BATTLE_LAYERS["bullets"] + i
                if i == 0 then fire.layer = fire.layer + 5 end
            end
        end)
    end)
end

function Arcs:onEnd()
    for _,fire in ipairs(self.bullets) do
        fire.ps:clear()
    end
end

return Arcs