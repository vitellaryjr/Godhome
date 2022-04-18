local Radiance, super = Class("nailbase")

function Radiance:init(x, y)
    super:init(self, x, y, "battle/p5/radiance/boss")
    self.sprite:play(0.3, true)
    self.layer = BATTLE_LAYERS["above_arena"]
    self.nail_hb = CircleCollider(self, self.width/2, 33, 12)
    self.collider.collidable = false
    self.enemy = Game.battle:getEnemyByID("p5/radiance")
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite.scale_x = 0

    self.glow = Sprite("enemies/p5/radiance/bg_glow", self.width/2, self.height/2)
    self.glow:setOrigin(0.5, 0.5)
    self.glow.layer = -10
    self.glow.alpha = 0
    self.glow.graphics.spin = -0.01
    self:addChild(self.glow)
end

function Radiance:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.3, self.sprite, {scale_x = 1})
    self.wave.timer:tween(0.3, self.glow, {alpha = 0.2})
end

function Radiance:setSprite(texture, speed, loop, on_finished)
    super:setSprite(self, texture, speed, loop, on_finished)
    self.sprite:setScaleOrigin(0.5, 0.5)
end

function Radiance:teleport(x, y)
    self.wave.timer:tween(0.3, self.sprite, {scale_x = 0})
    self.wave.timer:tween(0.3, self.glow, {alpha = 0})
    self.wave.timer:after(0.3, function()
        self:setPosition(x, y)
        self.wave.timer:tween(0.3, self.sprite, {scale_x = 1})
        self.wave.timer:tween(0.3, self.glow, {alpha = 0.2})
    end)
end

return Radiance