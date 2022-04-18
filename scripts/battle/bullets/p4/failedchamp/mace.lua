local Mace, super = Class("nailbase")

function Mace:init(x, y, dir, length)
    super:init(self, x, y)
    self.enemy = Game.battle:getEnemyByID("p4/failedchamp")
    self.double_damage = true
    self.hit_sfx = "bosses/false_knight_damage"
    self.hit_volume = 0.8

    self.sprite = Sprite("battle/p1/falseknight/mace", 0, 0)
    self.sprite:setOrigin(0.5, 0.5)
    self.sprite.inherit_color = true
    self:addChild(self.sprite)

    self.dir = dir
    self.length = length/2
    self.sprite:setPosition(self.length*math.cos(dir), self.length*math.sin(dir))
    self.sprite.rotation = dir
    self.collider = ColliderGroup(self, {
        CircleCollider(self, self.sprite.x, self.sprite.y, 12),
        LineCollider(self, 0,0, self.sprite.x,self.sprite.y),
    })
end

function Mace:draw()
    local r,g,b = unpack(self.color)
    love.graphics.setColor(r,g,b, self.alpha)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(2)
    love.graphics.line(0, 0, self.length*math.cos(self.dir), self.length*math.sin(self.dir))
    super:draw(self)
end

function Mace:hurt(amount, player)
    self.enemy:onNailHurt(amount, player)
    if self.enemy.armor_health <= 0 then
        self:onDefeat()
        Assets.playSound("bosses/false_knight_damage_down", 1)
    end
end

function Mace:onDefeat()
    self.wave.finished = true
    Game.battle.encounter.skip_turn = true
    self.enemy:setAnimation("fall")
end

function Mace:rotate(dir)
    self.dir = dir
    self.sprite:setPosition(self.length*math.cos(dir), self.length*math.sin(dir))
    self.sprite.rotation = dir
    self.collider.colliders[1].x = self.sprite.x
    self.collider.colliders[1].y = self.sprite.y
    self.collider.colliders[2].x2 = self.sprite.x
    self.collider.colliders[2].y2 = self.sprite.y
end

return Mace