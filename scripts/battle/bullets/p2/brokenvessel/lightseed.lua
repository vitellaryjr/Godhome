local Lightseed, super = Class("nailbase")

function Lightseed:init(x, y, dir, exp)
    super:init(self, x, y, "battle/p2/brokenvessel/lightseed")
    self.sprite:play(0.2, true)
    self.layer = BATTLE_LAYERS["below_arena"]
    self.physics = {
        speed = 6,
        friction = 1,
        direction = dir,
    }
    self.exp = exp
    if exp.x < x then
        self.scale_x = -2
    end

    self.timer = Timer()
    self:addChild(self.timer)
    self.health = 1
end

function Lightseed:onAdd(parent)
    self.timer:after(0.2, function()
        self.layer = BATTLE_LAYERS["bullets"]
        self.timer:tween(1, self, {x = self.exp.x, y = self.exp.y}, "in-out-quad")
        self.timer:after(0.9, function()
            local mask = ColorMaskFX({1,1,1}, 0)
            self:addFX(mask)
            self.timer:tween(0.1, mask, {amount = 1}, "linear", function()
                self.exp:add()
                self:fadeOutAndRemove(0.2)
            end)
        end)
    end)
end

function Lightseed:getDamage()
    return 0
end

return Lightseed