local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 6
end

function Arcs:onStart()
    local arena = Game.battle.arena
    self.timer:after(0.2, function()
        self.timer:everyInstant(0.8, function()
            local x = love.math.random(arena.left+20, arena.right-20)
            for i=-3,3 do
                local sx = i*3
                local fire = self:spawnBullet("p5/nkg/arcFireball", x, arena.top, sx)
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