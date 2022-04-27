-- yoooooo he got the drip
local Drop, super = Class(Sprite)

function Drop:init(x)
    super:init(self, "battle/misc/shapes/circle", x, -10)
    self.color = {0.2, 0.2, 0.4}
    self.alpha = 0.5
    self:setScale(0.5)
    self.physics = {
        speed = 2,
        direction = math.pi/2,
        gravity = 0.5,
        gravity_direction = math.pi/2,
    }
    Game.battle.timer:after(2, function() self:remove() end)
end

function Drop:update()
    super:update(self)
    self.scale_x = Utils.clampMap(self.physics.speed, 2,12, 0.5,0.3, "in-sine")
    self.scale_y = Utils.clampMap(self.physics.speed, 2,12, 0.5,1, "in-sine")
end

local DefenderDrip, super = Class(Object)

function DefenderDrip:init()
    super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 100
    Game.battle.timer:script(function(wait)
        while true do
            wait(Utils.random(0.5,2))
            self:addChild(Drop(love.math.random(SCREEN_WIDTH)))
        end
    end)
end

return DefenderDrip