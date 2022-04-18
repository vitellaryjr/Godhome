local Spikes, super = Class(Wave)

function Spikes:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(180)
end

function Spikes:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(2, function()
        self.timer:script(function(wait)
            local bullets = {}
            local count = Utils.pick{6,8}
            local amt = (count == 6) and 3 or 2
            local rot = Utils.pick{0, math.pi/2}
            for _=1,amt do
                local x = love.math.random(arena.left + 10, arena.right - 10)
                local y = love.math.random(arena.top + 10, arena.bottom - 10)
                local blob = self:spawnBullet("p3/hiveknight/spikeblob", x, y, count)
                blob.rotation = rot
                table.insert(bullets, blob)
                wait(0.2)
            end
            wait((count == 6) and 0.4 or 0.6)
            for _,blob in ipairs(bullets) do
                blob:eject()
                wait(0.4)
            end
        end)
    end)
end

return Spikes