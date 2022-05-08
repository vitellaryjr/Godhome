local Dash, super = Class("nailbase")

function Dash:init(x, y)
    super:init(self, x, y, "battle/p3/grimm/dash")
    self:setHitbox(6, 3, 27, 7)
    self.rotation = math.pi/2
    self.enemy = Game.battle:getEnemyBattler("p3/grimm")
end

function Dash:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.wave.timer:script(function(wait)
        wait(0.5)
        while true do
            local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
            while Utils.round(self.rotation % (math.pi*2), 0.1) ~= Utils.round(angle % (math.pi*2), 0.1) do
                self.rotation = Utils.approachAngle(self.rotation, angle, 0.3*DTMULT)
                wait()
            end
            wait(0.1)
            self.physics = {
                speed = 14,
                match_rotation = true,
            }
            wait(0.2)
            self.physics.friction = 3
            wait(0.4)
            self.collidable = false
            self.graphics.grow_x = 0.2
            self.graphics.grow_y = -0.4
            self.graphics.fade = 0.1
            local nx, ny = 0, 0
            if soul.x > arena.x then
                nx, ny = arena.left + arena.width*0.25, arena.top + arena.height*0.25
            else
                nx, ny = arena.left + arena.width*0.75, arena.top + arena.height*0.25
            end
            local ps = ParticleAbsorber(nx, ny, {
                layer = BATTLE_LAYERS["above_bullets"],
                shape = "triangle",
                color = {1,0.2,0.2},
                alpha = {0.5,0.8},
                blend = "screen",
                size = {8,32},
                spin_var = 0.2,
                dist = 32,
                move_time = 0.1,
                fade_in = 0.1,
                amount = {2,3},
                every = 0.01,
                draw = function(p, orig)
                    local r, g, b = unpack(p.color)
                    local a = p.alpha
                    love.graphics.setColor(r*a, g*a, b*a)
                    orig:draw(p)
                end,
            })
            self.wave:addChild(ps)
            while self.scale_y > 0 do
                wait()
            end
            ps:clear()
            ps:remove()
            self.collidable = true
            self.graphics.grow_x = 0
            self.graphics.grow_y = 0
            self.graphics.fade = 0
            self:setScale(2)
            self.alpha = 1

            self.rotation = math.pi/2
            self:setPosition(nx, ny)
            self.wave:addChild(ParticleEmitter(self.x, self.y, {
                layer = BATTLE_LAYERS["above_bullets"],
                shape = "triangle",
                color = {1,0.2,0.2},
                alpha = {0.5,0.8},
                blend = "screen",
                size = {8,32},
                spin_var = 0.2,
                speed = {4,6},
                friction = 0.2,
                fade = 0.04,
                fade_after = 0.1,
                amount = {16,20},
                draw = function(p, orig)
                    local r, g, b = unpack(p.color)
                    local a = p.alpha
                    love.graphics.setColor(r*a, g*a, b*a)
                    orig:draw(p)
                end,
            }))
            wait(0.2)
        end
    end)
end

function Dash:hit(source, damage)
    local prev_hp = self.enemy.health
    super:hit(self, source, damage)
    if prev_hp ~= self.enemy.max_health and (self.enemy.health % (self.enemy.max_health/3) > prev_hp % (self.enemy.max_health/3)) then
        self.enemy.pufferfish = true
    end
end

return Dash