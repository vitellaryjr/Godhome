local GrassPuff, super = Class(Object)

function GrassPuff:init(x, y, size, dir, angle)
    super:init(self, x, y, size, 2)
    self:setOrigin(0.5,0.5)
    self.rotation = dir + math.pi/2
    for i=1,math.ceil(size/8) do
        local x = i*8 - love.math.random(2,6)
        local sprite = Sprite("battle/p1/mosscharger/leaf_"..Utils.pick{"a","b","c"}, x, 0)
        sprite.color = Game.battle.arena.color
        sprite:setOrigin(0.5, 0.5)
        sprite:setScale(2)
        sprite.physics = {
            speed = Utils.random(-2,-5),
            direction = angle + Utils.random(-0.1,0.1),
            friction = 0.2,
        }
        sprite.graphics.spin = Utils.random(-0.1,0.1)
        sprite.graphics.fade = Utils.random(0.02,0.04)
        self:addChild(sprite)
    end
    Assets.playSound("bosses/moss_charger_emerge")
end

return GrassPuff