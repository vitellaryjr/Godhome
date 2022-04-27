local Drop, super = Class(Sprite)

function Drop:init(x, color)
    super:init(self, "battle/misc/shapes/circle", x, -10)
    self.color = color
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

local PaintDrip, super = Class(Object)

function PaintDrip:init()
    super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 100
    self.colors = {}
end

function PaintDrip:addColor(color)
    table.insert(self.colors, color)
    if #self.colors == 1 then
        Game.battle.timer:script(function(wait)
            while true do
                local min = Utils.clampMap(#self.colors, 1,8, 2,0.1)
                wait(Utils.random(min, min*2))
                self:addChild(Drop(love.math.random(SCREEN_WIDTH), Utils.pick(self.colors)))
            end
        end)
    end
end

return PaintDrip