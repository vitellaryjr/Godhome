local Ball, super = Class("nailbase")

function Ball:init(x, y, dir, grav_dir)
    super:init(self, x, y, "battle/p3/godtamer/ballin")
    self.color = {1,1,1}
    self.collider = CircleCollider(self, self.width/2, self.height/2, 15)
    self.wall_collider = CircleCollider(self, self.width/2, self.height/2, 17)

    self.enemy = Game.battle:getEnemyByID("p3/beast")

    if Utils.sign(math.cos(dir)) * Utils.sign(math.sin(grav_dir)) == -1 then
        self.scale_x = -2
        self.graphics.spin = -0.3
    else
        self.graphics.spin = 0.3
    end

    self.physics = {
        speed = 10,
        direction = dir,
    }

    self.down = grav_dir
    self.vulnerable = false
    self.done = false
end

function Ball:onAdd(parent)
    super:onAdd(self, parent)
    if self.done then return end
    self.done = true
    local arena = Game.battle.arena
    self.wave.timer:script(function(wait)
        while not self.wall_collider:collidesWith(arena) do
            wait()
        end
        while self.wall_collider:collidesWith(arena) do
            wait()
        end
        wait(0.05)
        Mod:revertArenaCorner(arena, 0.2)
        while not self.wall_collider:collidesWith(arena) do
            wait()
        end
        self:setParent(Game.battle)
        local dir_x = Utils.sign(math.cos(self.physics.direction))*-1
        local dir_y = Utils.sign(math.sin(self.down))*-1
        self.physics = {
            speed_x = 2.9*dir_x,
            speed_y = 12*dir_y,
            gravity = 0.8,
            gravity_direction = self.down,
        }
        local floor = (dir_y == -1) and 3 or 1
        while not self.wall_collider:collidesWith(arena.collider.colliders[floor]) do
            wait()
        end
        self.physics.speed_x = 0
        self.physics.speed_y = 4*dir_y

        self:setParent(Game.battle.mask)
        self.vulnerable = true
        self.color = {1, 0.8, 0.5}
        local mask = ColorMaskFX({1,0.8,0.5}, 1)
        self:addFX(mask)
        self.wave.timer:tween(0.3, mask, {amount = 0})
    end)
end

function Ball:hit(source, damage)
    if self.vulnerable then
        super:hit(self, source, damage)
    else
        -- special "no damage" animation?
    end
end

return Ball