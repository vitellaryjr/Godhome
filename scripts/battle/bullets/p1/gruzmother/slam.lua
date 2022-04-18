local Slam, super = Class("nailbase")

function Slam:init(x, y)
    super:init(self, x, y, "battle/p1/gruzmother/charge")
    self.sprite:play(0.1, true)
    self.nail_hb = Hitbox(self, 1,5, 22,20)
    self.enemy = Game.battle:getEnemyByID("p1/gruzmother")

    local arena = Game.battle.arena
    local soul = Game.battle.soul
    if self.x > soul.x then
        self.scale_x = -2
        self.dir_x = -1
    else
        self.scale_x = 2
        self.dir_x = 1
    end
    if self.y < arena.y then
        self.dir_y = 1
    else
        self.dir_y = -1
    end

    self.charging = false

    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        self.physics = {
            speed_x = 0,
            speed_y = -2*self.dir_y,
            friction = 0.2,
        }
        wait(0.5)
        while true do
            self.physics = {
                speed_x = 1*self.dir_x,
                speed_y = 10*self.dir_y,
            }
            self.charging = true
            while self.charging do
                wait()
            end
            timer:during(0.2, function(dt)
                arena.sprite:setPosition(love.math.random(-2,2),love.math.random(-2,2))
            end, function()
                arena.sprite:setPosition(0,0)
            end)
            wait()
            self.dir_y = self.dir_y * -1
            if math.abs(self.x - arena.x) > arena.width/2 - 30 then
                self.dir_x = self.dir_x * -1
                self.scale_x = self.dir_x * 2
            end
            self.physics = {}
            wait(0.1)
        end
    end)
end

function Slam:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    if self.charging then
        if Game.battle:checkSolidCollision(self) then
            self.charging = false
            self:setPosition(
                Utils.clamp(self.x, arena.left + self.collider.width+1, arena.right - self.collider.width-1),
                Utils.clamp(self.y, arena.top + self.collider.height+1, arena.bottom - self.collider.height-1)
            )
        end
    else
        self:setPosition(
            Utils.clamp(self.x, arena.left + self.collider.width+1, arena.right - self.collider.width-1),
            Utils.clamp(self.y, arena.top + self.collider.height+1, arena.bottom - self.collider.height-1)
        )
    end
end

function Slam:onDefeat()
    if Game.battle.encounter.difficulty > 1 then
        self.enemy.health = 4
    else
        super:onDefeat(self)
        self.wave.finished = true
    end
end

return Slam