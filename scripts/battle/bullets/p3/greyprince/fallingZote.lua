local Fall, super = Class("nailbase")

function Fall:init(x, y, amt)
    super:init(self, x, y, "battle/p3/greyprince/fall")
    self.sprite:play(0.1, true)
    self:setHitbox(9, 8, 16, 6)
    
    self.enemy = Game.battle:getEnemyByID("p3/greyprince")

    self.physics = {
        speed_y = 0,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    self.amt = amt or love.math.random(1, 4)
    self.started = false
end

function Fall:onAdd(parent)
    super:onAdd(self, parent)
    if not self.started then
        self.started = true
        local arena = Game.battle.arena
        local soul = Game.battle.soul
        self.wave.timer:script(function(wait)
            while self.y < arena.top + 28 do
                wait()
            end
            self:setParent(Game.battle.mask)
            while self.y < arena.bottom - 28 do
                wait()
            end
            local x, y = self.x, arena.bottom
            if self.amt <= 0 then
                self.physics = {}
                self:setSprite("battle/p3/greyprince/land", 0.1, false)
                self:setHitbox(13, 8, 16, 6)
                self.y = arena.bottom - 14
                if self.amt == 0 then
                    local forward = Utils.sign(soul.x - self.x)
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4 * forward)
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 40, 120, 4 * forward)
                else
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4)
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, 4)
                end
                wait(1.6)
                self.wave.finished = true
            else
                self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4)
                self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, 4)
                wait(0.2)
                self.wave:spawnFallingZote(self.amt - 1)
            end
        end)
    end
end

return Fall