local Orb, super = Class(Bullet)

function Orb:init(x, y, time, dir, spawnspeed, speed)
    super:init(self, x, y, "battle/common/soulorb")
    self.sprite:play(0.15, true)
    self.collider = CircleCollider(self, self.width/2, self.height/2, 4)
    self.destroy_on_hit = true

    time = time or -1
    local soul = Game.battle.soul
    dir = dir or Utils.angle(self.x, self.y, soul.x, soul.y)
    spawnspeed = spawnspeed or 0.05
    speed = speed or 10
    self.physics = {
        speed_x = (spawnspeed == 0) and speed*math.cos(dir) or 0,
        speed_y = (spawnspeed == 0) and speed*math.sin(dir) or 0,
    }
    self.graphics.remove_shrunk = true

    self.spawning = spawnspeed > 0
    if self.spawning then
        self.collidable = false
        self.sprite:setAnimation{"battle/common/soulorb_spawn", spawnspeed, false, callback = function()
            self.sprite:setAnimation{"battle/common/soulorb", 0.15, true}
            self.collidable = true
            self.spawning = false
            self.physics = {
                speed_x = speed*math.cos(dir),
                speed_y = speed*math.sin(dir),
            }
            Game.battle:addChild(ParticleEmitter(self.x, self.y, {
                layer = "below_bullets",
                shape = "arc",
                alpha = {0.5,0.6},
                blend = "add",
                spin_var = 0.5,
                scale = 1.2,
                angles = {0, 2*math.pi},
                physics = {
                    speed = 4,
                    speed_var = 1,
                    friction = 0.2,
                },
                fade = 0.02,
                shrink = 0.1,
                shrink_after = 0.2,
                amount = {4,5},
            }))
        end}
    end
    if time > 0 then
        Game.battle.timer:after(time, function()
            self.physics.friction = 0.1
            self.graphics.grow = -0.4
        end)
    end
end

function Orb:update(dt)
    super:update(self, dt)
    if not self.spawning then
        local soul = Game.battle.soul
        local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
        self.physics.speed_x = Utils.approach(self.physics.speed_x, 8*math.cos(angle), 0.25*DTMULT)
        self.physics.speed_y = Utils.approach(self.physics.speed_y, 8*math.sin(angle), 0.25*DTMULT)
    end
end

function Orb:destroy()
    Game.battle:addChild(ParticleEmitter(self.x, self.y, {
        layer = "below_bullets",
        shape = "arc",
        alpha = {0.5,0.6},
        blend = "add",
        spin_var = 0.5,
        scale = 1.2,
        angles = {0, 2*math.pi},
        physics = {
            speed = 4,
            speed_var = 1,
            friction = 0.2,
        },
        fade = 0.02,
        shrink = 0.1,
        shrink_after = 0.2,
        amount = {4,5},
    }))
    self:remove()
end

return Orb