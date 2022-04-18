local Lance, super = Class("nailbase")

function Lance:init(x, y, dir, fast)
    super:init(self, x, y, "battle/p2/mantislords/lance")
    self.rotation = dir
    self.dir = dir
    self:setHitbox(5,2,60,2)
    self.physics = {
        speed = 6,
        friction = 1,
        direction = dir+math.pi,
    }
    self.alpha = 0
    self.graphics = {
        fade_to = 1,
        fade = 0.1,
    }

    local timer = Timer()
    self:addChild(timer)
    timer:after(fast and 0.3 or 0.5, function()
        self.physics = {
            speed = fast and 18 or 14,
            direction = dir,
        }
        self.scythe:dash(true)
        timer:script(function(wait)
            while not Game.battle:checkSolidCollision(self) do
                wait()
            end
            while Game.battle:checkSolidCollision(self) do
                wait()
            end
            wait(0.05)
            self:setParent(Game.battle.mask)
            while not Game.battle:checkSolidCollision(self) do
                wait()
            end
            self.physics.speed = 0
            wait(0.5)
            self:fadeOutAndRemove(0.1)
        end)
    end)
end

function Lance:onAdd(parent)
    super:onAdd(self, parent)
    if not self.scythe then
        self.scythe = self.wave:spawnBullet("p2/mantislords/dash_scythe", self.x, self.y, self.dir)
    end
end

function Lance:onDefeat()
    self.enemy.health = 1
end

return Lance