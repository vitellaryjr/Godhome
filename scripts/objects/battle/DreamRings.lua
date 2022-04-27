local Ring, R_super = Class(Sprite)

function Ring:init(x, y, color, alpha, time, instant)
    self.type = "big_"..Utils.pick{"a","b"}
    R_super:init(self, "battle/misc/dream/"..self.type, x, y)
    self:setOrigin(0.5, 0.5)
    self.color = color
    self.graphics = {
        spin = Utils.random(-0.01,0.01),
    }
    self.physics = {
        speed_y = -0.2,
        speed_x = Utils.random(-0.1),
    }
    local arc_count = Utils.pick{6,8,9,10,12,15}
    for i=1,arc_count do
        local arc = Sprite("battle/misc/dream/"..self.type.."_arc", self.width/2, self.height/2)
        arc:setOrigin(0.5, 0.5)
        arc.inherit_color = true
        arc.rotation = (2*math.pi)*(i/arc_count)
        self:addChild(arc)
    end

    self.fading = false
    self.timer = Timer()
    self:addChild(self.timer)
    if instant then
        self.canvas_alpha = alpha or 1
        if time then
            self.timer:after(Utils.random(time), function()
                self.fading = true
                self.timer:tween(1, self, {canvas_alpha = 0}, "linear", function()
                    self.timer:after(Utils.random(1), function()
                        self.spawner:spawnRing()
                        self:remove()
                    end)
                end)
            end)
        end
    else
        if time then
            self.canvas_alpha = 0
            self.timer:tween(1, self, {canvas_alpha = alpha or 1}, "linear", function()
                self.timer:after(math.max(time-2, 0), function()
                    self.fading = true
                    self.timer:tween(1, self, {canvas_alpha = 0}, "linear", function()
                        self.timer:after(Utils.random(1), function()
                            self.spawner:spawnRing()
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

function Ring:update()
    R_super:update(self)
    if self.x < 0-self.width/2 then
        self.x = self.x + SCREEN_WIDTH + self.width
    elseif self.x > SCREEN_WIDTH+self.width/2 then
        self.x = self.x - SCREEN_WIDTH - self.width
    elseif self.y < 0-self.height/2 then
        self.y = self.y + SCREEN_HEIGHT + self.height
    elseif self.y > SCREEN_HEIGHT+self.height/2 then
        self.y = self.y - SCREEN_HEIGHT - self.height
    end
end

function Ring:draw()
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    R_super:draw(self)
    Draw.popCanvas()
    love.graphics.setColor(1,1,1, self.canvas_alpha)
    love.graphics.setBlendMode("add")
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
end

function Ring:onRemove(parent)
    Utils.removeFromTable(self.spawner.rings, self)
    R_super:onRemove(self, parent)
end

local DreamRings, D_super = Class(Object)

function DreamRings:init(colors, alpha, amount, time)
    D_super:init(self)
    self.layer = BATTLE_LAYERS["bottom"] + 20
    if type(colors[1]) == "number" then colors = {colors} end
    self.colors = colors
    self.alpha = alpha
    self.time = time
    amount = amount or 8
    self.rings = {}
    if self.time then
        local timer = Timer()
        self:addChild(timer)
        for _=1,math.floor(amount/2) do
            self:spawnRing(true)
        end
        timer:every(time/2, function()
            self:spawnRing(false)
        end, math.ceil(amount/2))
    else
        for _=1,amount do
            self:spawnRing(true)
        end
    end
end

function DreamRings:spawnRing(instant)
    if not self.stage then return end
    local x, y = love.math.random(SCREEN_WIDTH), love.math.random(SCREEN_HEIGHT)
    local ring = Ring(x, y, Utils.pick(self.colors), self.alpha, self.time, instant)
    ring:setLayer(self.layer)
    ring.spawner = self
    table.insert(self.rings, ring)
    self.parent:addChild(ring)
end

return DreamRings