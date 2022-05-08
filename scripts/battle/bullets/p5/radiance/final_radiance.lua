local Radiance, super = Class("nailbase")

function Radiance:init(x, y)
    super:init(self, x, y, "enemies/p5/radiance/idle")
    self.sprite:play(0.15, true)
    self.color = {1,1,1}
    self.layer = BATTLE_LAYERS["above_arena"] + 50
    self.nail_hb = CircleCollider(self, self.width/2, 33, 12)
    self.collider.collidable = false
    self.enemy = Game.battle:getEnemyBattler("p5/radiance")
    self.sprite:setScaleOrigin(0.5, 0.5)
    self.sprite.scale_x = 0

    self.remove_offscreen = false

    self.glow = Sprite("enemies/p5/radiance/bg_glow", self.width/2, self.height/2)
    self.glow:setOrigin(0.5, 0.5)
    self.glow.layer = -10
    self.glow.alpha = 0
    self.glow.graphics.spin = -0.01
    self:addChild(self.glow)

    self.defeated = false
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

function Radiance:hit(source, damage)
    super:hit(self, source, damage)
    local mask = ColorMaskFX({1,0.95,0.7}, 1)
    self.sprite:addFX(mask)
    self.wave.timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self.sprite:removeFX(mask)
    end)
    Game.battle:addChild(ParticleEmitter(self.x, self.y - 5, {
        layer = "above_bullets",
        path = "battle/misc/dream",
        shape = {"small_a", "small_b"},
        color = {1,0.95,0.7},
        alpha = {0.5,0.7},
        blend = "add",
        speed = {3,10},
        angle = Utils.angle(source.x, source.y, self.x, self.y - 5),
        angle_var = 0.3,
        spin = {-0.05, 0.05},
        shrink = 0.07,
        amount = {6,8},
    }))
end

function Radiance:onDefeat()
    self.defeated = true
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