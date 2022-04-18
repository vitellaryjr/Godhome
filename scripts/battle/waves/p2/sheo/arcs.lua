local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 7
end

function Arcs:onStart()
    local arena = Game.battle.arena
    self.timer:everyInstant(1, function()
        local corner = love.math.random(4)
        local angle = (corner-1)*math.pi/2
        local point = arena.shape[corner]
        local x, y = arena:getRelativePos(point[1], point[2], Game.battle)
        self:addChild(ParticleEmitter(x, y, {
            layer = BATTLE_LAYERS["above_arena"],
            shape = "circle",
            color = {0.4, 0.4, 1},
            angle = {angle, angle + math.pi/2},
            size = {8,10},
            speed = {2,4},
            friction = 0.1,
            shrink = 0.1,
            shrink_after = {0.1,0.2},
            amount = {1,2},
            every = 0.1,
            time = 0.5,
            mask = true,
        }))
        self.timer:after(0.5, function()
            local b1 = self:spawnBullet("p2/sheo/paintblob", x, y)
            local b2 = self:spawnBullet("p2/sheo/paintblob", x, y)
            local b3 = self:spawnBullet("p2/sheo/paintblob", x, y)
            local sx = -1*Utils.sign(x - arena.x)
            local sy = -3*Utils.sign(y - arena.y)
            local grav = math.pi/2*Utils.sign(y - arena.y)
            b1.physics = {
                speed_x = sx,
                speed_y = sy,
                gravity = 0.25,
                gravity_direction = grav,
            }
            b2.physics = {
                speed_x = sx*2,
                speed_y = sy*2,
                gravity = 0.25,
                gravity_direction = grav,
            }
            b3.physics = {
                speed_x = sx*3,
                speed_y = sy*3,
                gravity = 0.25,
                gravity_direction = grav,
            }
        end)
    end)
end

return Arcs