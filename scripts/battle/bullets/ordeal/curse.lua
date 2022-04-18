local Curse, super = Class("ordeal/zotebase")

function Curse:init(x, y)
    super:init(self, x, y, "battle/ordeal/curse")
    self.sprite:play(0.3, true)
    self.collider.collidable = false
    self.nail_hb = Hitbox(self, 7,7, 11,16)
    self.health = 60

    self.ox, self.oy = x, y
    self.sine = Utils.random(math.pi*2)
end

function Curse:onAdd(parent)
    super:onAdd(self, parent)
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    local timer = Timer()
    self:addChild(timer)
    timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self:removeFX(mask)
    end)
    timer:every(0.4, function()
        local soul = Game.battle.soul
        local orb = Sprite("battle/misc/shapes/circle", soul.x + love.math.random(-6,6), soul.y + love.math.random(-6,6))
        orb:setLayer(BATTLE_LAYERS["below_soul"])
        orb:setScale(0.3)
        orb.alpha = 0.5
        orb.lerp = 0
        Game.battle:addChild(orb)
        local ox, oy = orb.x, orb.y
        self.wave.timer:tween(1, orb, {lerp = 1})
        self.wave.timer:during(1, function(dt)
            orb.x = Utils.lerp(ox, self.x, orb.lerp)
            orb.y = Utils.lerp(oy, self.y, orb.lerp)
        end, function()
            orb:remove()
            Game.battle.tension_bar:removeTension(0.8)
        end)
    end)
end

function Curse:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    self.sine = self.sine + dt
    self.x = self.ox + math.sin(self.sine)*(arena.width/2 - 20)
    self.y = self.oy + math.sin(self.sine*4)*5
end

return Curse