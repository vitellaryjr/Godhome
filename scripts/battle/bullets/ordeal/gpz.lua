local Fall, super = Class("ordeal/zotebase")

function Fall:init()
    local arena = Game.battle.arena
    super:init(self, love.math.random(arena.left + 30, arena.right - 30), -30, "battle/ordeal/gpz_fall")
    self.sprite:play(0.1, true)
    self:setHitbox(9,8, 16,6)
    self.health = 100
    self.immune = true

    self.physics = {
        speed_y = 0,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    self.amt = love.math.random(1,4)
    self.started = false
end

function Fall:onAdd(parent)
    super:onAdd(self, parent)
    if not self.started then
        self.started = true
        local arena = Game.battle.arena
        local soul = Game.battle.soul
        local timer = Timer()
        self:addChild(timer)
        timer:script(function(wait)
            while true do
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
                    self:setSprite("battle/ordeal/gpz_land", 0.1, false)
                    self:setHitbox(14,8, 16,6)
                    self.y = arena.bottom - 14
                    if self.amt == 0 then
                        local forward = Utils.sign(soul.x - self.x)
                        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4 * forward)
                        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 40, 100, 4 * forward)
                    else
                        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4)
                        self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, 4)
                    end
                    wait(1)
                    self:setSprite("battle/ordeal/gpz_fall", 0.1, true)
                    self:setHitbox(9,8, 16,6)
                    self.physics = {
                        speed_y = -8,
                        gravity = 0.7,
                        gravity_direction = math.pi/2,
                    }
                    wait(1.3)
                    self.amt = love.math.random(1,4)
                else
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, -4)
                    self.wave:spawnBulletTo(Game.battle.mask, "common/shockwave", x, y, 60, 60, 4)
                    wait(0.2)
                    self.amt = self.amt - 1
                end
                self:setParent(Game.battle)
                self:setPosition(love.math.random(arena.left + 30, arena.right - 30), -30)
                self.physics = {
                    speed_y = 0,
                    gravity = 0.5,
                    gravity_direction = math.pi/2,
                }
            end
        end)
    end
end

return Fall