local Charge, super = Class("nailbase")

function Charge:init(x, y)
    super:init(self, x, y, "battle/p1/gruzmother/fly")
    self.sprite:play(0.2, true)
    self.nail_hb = Hitbox(self, 1,5, 22,20)
    self.enemy = Game.battle:getEnemyBattler("p1/gruzmother")

    local arena = Game.battle.arena
    local soul = Game.battle.soul
    if self.x > soul.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end

    self.charging = false

    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        wait(0.5)
        while true do
            self.sprite:setSprite("battle/p1/gruzmother/charge")
            if self.x > soul.x then
                self.scale_x = -2
            else
                self.scale_x = 2
            end
            self.sprite:play(0.1, true)
            local angle = Utils.angle(self.x, self.y, soul.x, soul.y)
            self.physics = {
                speed = 2,
                direction = angle + math.pi,
            }
            wait(0.4)
            self.physics = {
                speed = 8,
                direction = angle,
            }
            self:setPosition(
                Utils.clamp(self.x, arena.left + self.collider.width+1, arena.right - self.collider.width-1),
                Utils.clamp(self.y, arena.top + self.collider.height+1, arena.bottom - self.collider.height-1)
            )
            self.charging = true
            while self.charging do
                wait()
            end
            self.sprite:setSprite("battle/p1/gruzmother/fly")
            self.sprite:play(0.2, true)
            self.physics = {
                speed = 3,
                friction = 0.3,
                direction = angle + math.pi,
            }
            wait(0.5)
        end
    end)
end

function Charge:update()
    super:update(self)
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

function Charge:onDefeat()
    if Game.battle.encounter.difficulty > 1 then
        self.enemy.health = 7
    else
        super:onDefeat(self)
        self.wave.finished = true
    end
end

return Charge