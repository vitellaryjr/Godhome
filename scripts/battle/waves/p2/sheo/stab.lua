local Stabs, super = Class(Wave)

function Stabs:init()
    super:init(self)
    self.time = 7
end

function Stabs:onStart()
    local arena = Game.battle.arena
    self.timer:after(0.5, function()
        self.timer:everyInstant(1, function()
            local x, y, dir = Mod:getPointOnEdge(arena)
            self:addChild(ParticleEmitter(x, y, {
                color = {1, 0.95, 0.4},
                size = {8,10},
                angle = dir,
                angle_var = math.pi/3,
                speed = {2,4},
                friction = 0.1,
                shrink = 0.1,
                shrink_after = {0.1,0.2},
                every = 0.1,
                time = 0.8,
            }))
            self.timer:after(0.8, function()
                self:spawnBulletTo(Game.battle.mask, "p2/sheo/stab", x, y, dir)
            end)
        end)
    end)
end

return Stabs