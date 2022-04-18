local Blob, super = Class(Object)

function Blob:init(x, y, radius)
    super:init(self, x, y)
    self.radius = radius
    self.orig_radius = radius
    Game.battle.timer:every(Utils.random(1,1.2), function()
        self.radius = self.orig_radius*1.1
        Game.battle.timer:tween(0.5, self, {radius = self.orig_radius}, "out-quad")
    end)
end

function Blob:draw()
    love.graphics.setColor(1,0.55,0.2, 0.4)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    super:draw(self)
end

local Infection, super = Class(Object)

function Infection:init()
    super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 100
    self:addChild(Blob(10,0, 50))
    self:addChild(Blob(40,-5, 20))
    self:addChild(Blob(330,-2, 90))

    local ui = UIAttachment(60)
    self:addChild(ui)
    ui:addChild(Blob(45,3, 40))
    ui:addChild(Blob(208,4, 35))
    ui:addChild(Blob(230,6, 20))
end

return Infection