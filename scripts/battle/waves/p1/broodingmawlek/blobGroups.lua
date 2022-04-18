local Groups, super = Class(Wave)

function Groups:init()
    super:init(self)
    self.time = 8
end

function Groups:onStart()
    local arena = Game.battle.arena
    self:spawnBullet("p1/broodingmawlek/mouth", arena.x, arena.bottom)
    local soul = Game.battle.soul
    self.ps = ParticleEmitter(arena.x, arena.bottom - 10, {
        auto = false,
        shape = "circle",
        color = {1, 0.8, 0.5},
        alpha = 0.5,
        rotation = {-0.4, 0.4},
        width = 8, height = {12, 16},
        angle = function(p) return p.rotation - math.pi/2 end,
        physics = {
            speed = 4,
            speed_var = 1,
            friction = 0.2,
        },
        shrink = 0.02,
        every = 0.1,
        amount = {1,2},
    })
    Game.battle:addChild(self.ps)
    self.timer:after(0.6, function()
        self.ps.data.auto = true
        self.timer:after(0.6, function()
            self.ps.data.auto = false
        end)
        self.timer:every(1.2, function()
            self.ps.data.auto = true
            self.timer:after(0.4, function()
                self.ps.data.auto = false
            end)
        end)
    end)
    self.timer:every(1.2, function()
        for i=1,10 do
            local bullet = self:spawnBullet("common/infection", arena.left + arena.width/2, arena.bottom)
            bullet.tp = 0.16
            bullet.physics = {
                speed_x = Utils.random(2) * (soul.x < arena.x and -1 or 1),
                speed_y = -11 + Utils.random(-0.3,0.3),
                gravity = 0.4,
                gravity_direction = math.pi/2,
            }
        end
    end)
end

function Groups:onEnd()
    self.ps:remove()
end

return Groups