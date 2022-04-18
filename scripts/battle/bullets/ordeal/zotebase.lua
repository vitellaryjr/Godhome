local Zote, super = Class("nailbase")

function Zote:init(x, y, texture)
    super:init(self, x, y, texture)

    self.health = 1
    self.immune = false
end

function Zote:onDefeat()
    Utils.removeFromTable(self.wave.zotes, self)
    Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
    self.wave:increaseKillCount()
    self:killAnim()
end

function Zote:killAnim()
    local head = Sprite("battle/ordeal/zote_kill", self.x, self.y)
    head:setLayer(BATTLE_LAYERS["below_bullets"])
    head:setScale(2)
    head:setOrigin(0.5, 0.5)
    head.physics = {
        speed_x = Utils.random(-3,3),
        speed_y = -8,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    head.graphics.spin = Utils.sign(head.physics.speed_x)*0.3
    Game.battle:addChild(head)
    head:fadeOutAndRemove(0.02)
    self:remove()
end

return Zote