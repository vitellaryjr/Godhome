local Cloud, C_super = Class(Sprite)

function Cloud:init(x, y, time, instant)
    C_super:init(self, "battle/misc/shapes/circle", x, y)
    self:setOrigin(0.5, 0.5)
    self.color = {0.5,1,1}
    local next_alpha = 0.03
    self:setScale(love.math.random(6,12))
    self.graphics = {
        spin = Utils.random(-0.01,0.01),
    }
    self.physics = {
        speed_y = Utils.random(-0.1,-0.2),
    }

    local timer = Timer()
    self:addChild(timer)
    if instant then
        self.alpha = next_alpha
        if time then
            timer:after(Utils.random(time), function()
                timer:tween(1, self, {alpha = 0}, "linear", function()
                    timer:after(Utils.random(1), function()
                        self.parent:spawnCloud()
                        self:remove()
                    end)
                end)
            end)
        end
    else
        if time then
            self.alpha = 0
            timer:tween(1, self, {alpha = next_alpha}, "linear", function()
                timer:after(math.max(time-2, 0), function()
                    timer:tween(1, self, {alpha = 0}, "linear", function()
                        timer:after(Utils.random(1), function()
                            self.parent:spawnCloud()
                            self:remove()
                        end)
                    end)
                end)
            end)
        else
            self.canvas_alpha = alpha or 1
        end 
    end
end

local Fog, super = Class(Object)

function Fog:init()
    super:init(self)
    self.layer = BATTLE_LAYERS["below_ui"]
    local time = 6
    local amount = 50
    local timer = Timer()
    self:addChild(timer)
    for _=1,math.floor(amount/2) do
        self:spawnCloud(true)
    end
    timer:every(time/2, function()
        self:spawnCloud(false)
    end, math.ceil(amount/2))
end

function Fog:spawnCloud(instant)
    local x, y = love.math.random(SCREEN_WIDTH), love.math.random(SCREEN_HEIGHT)
    self:addChild(Cloud(x, y, 6, instant))
end

return Fog