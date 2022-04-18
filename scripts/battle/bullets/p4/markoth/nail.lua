local Sword, super = Class(Bullet)

function Sword:init(x, y, fast)
    super:init(self, x, y, "battle/p4/markoth/nail")
    self:setHitbox(8,2,16,3)
    local soul = Game.battle.soul
    self.rotation = Utils.angle(self, soul)
    self.physics = {
        speed = 6,
        friction = 0.5,
        direction = self.rotation + math.pi,
    }
    self:addFX(ColorMaskFX(), "mask")

    self.fast = fast or false
end

function Sword:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.5, self:getFX("mask"), {amount = 0})
    local soul = Game.battle.soul
    self.wave.timer:script(function(wait)
        while self.physics.speed > 0 do
            self.rotation = Utils.angle(self, soul)
            self.physics.direction = self.rotation + math.pi
            wait()
        end
        wait(self.fast and 0.2 or 0.3)
        self.physics = {
            speed = 10,
            direction = self.rotation,
        }
    end)
end

return Sword