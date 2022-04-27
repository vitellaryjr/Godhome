local ZoteHopper, super = Class("nailbase")

function ZoteHopper:init(x)
    super:init(self, x, Game.battle.arena.bottom - 26, "battle/p3/greyprince/hopper_idle")
    self.sprite:play(0.3, true)

    self.health = 30
    self.knockback = 0
end

function ZoteHopper:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    self.wave.timer:script(function(wait)
        while true do
            wait(Utils.random(0.5,1.5))
            self.knockback = 8
            self.physics = {
                speed_y = -8,
                speed_x = Utils.random(-6,6),
                gravity = 0.3,
                gravity_direction = math.pi/2,
            }
            self:setSprite("battle/p3/greyprince/hopper_jump", 0, false)
            while self.y < arena.bottom - 25 do
                wait()
            end
            self.knockback = 0
            self.curr_knockback = 0
            self.physics = {}
            self.y = arena.bottom - 26
            self:setSprite("battle/p3/greyprince/hopper_idle", 0.3, true)
        end
    end)
end

function ZoteHopper:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.x < arena.left or self.x > arena.right then
        self.physics.speed_x = self.physics.speed_x * -1
        self.x = Utils.clamp(self.x, arena.left, arena.right)
    end
end

function ZoteHopper:onDefeat()
    Utils.removeFromTable(self.wave.enemies, self)
    if #self.wave.enemies == 0 then
        Game.battle.timer:after(0.5, function()
            self.wave.finished = true
        end)
    end
    super:onDefeat(self)
end

return ZoteHopper