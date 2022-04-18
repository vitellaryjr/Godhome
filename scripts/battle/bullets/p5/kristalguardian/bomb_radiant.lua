local Laser, super = Class("p5/kristalguardian/bomb_base")

function Laser:init(x)
    super:init(self, x, "radiant")
end

function Laser:explode()
    self.physics.speed_y = 0
    local angle = Utils.random(math.pi*2)
    local lasers = {}
    for i=1,8 do
        local laser = self.wave:spawnBulletTo(self, "common/crystal/laser", self.width/2, self.height/2, 0, 0.25)
        laser.rotation = angle + i*math.pi/4
        table.insert(lasers, laser)
    end
    self.wave.timer:after(0.75, function()
        -- for _,laser in ipairs(lasers) do
        --     laser:relase(self.x, self.y)
        -- end
        -- super:explode(self)
        self.sprite:remove()
        Assets.playSound("bosses/jevil_bomb", 0.8)
        self.wave.timer:after(0.8, function()
            self:remove()
        end)
    end)
end

return Laser