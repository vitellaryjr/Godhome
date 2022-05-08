local Defender, super = Class("nailbase")

function Defender:init(x, y)
    super:init(self, x, y, "battle/p1/dungdefender/defenderball")
    self.rotation = Utils.random(2*math.pi)
    self.graphics.spin = 0.3
    self.collider = CircleCollider(self, self.width/2, self.height/2, 10)
    self.enemy = Game.battle:getEnemyBattler("p1/dungdefender")
    self.physics = {
        speed_y = -16,
        gravity = 1.2,
        gravity_direction = math.pi/2,
    }
end

function Defender:update()
    super:update(self)
    local arena = Game.battle.arena
    if self.y > arena.bottom+20 then
        self:remove()
    end
end

return Defender