local Lighting, super = Class(Object)

-- alpha is how dark the room should be (with 1 being full darkness) (defaults to 1)
-- color is what color the light sources will be (defaults to white)
-- fade is an optional argument that makes the darkness fade in
function Lighting:init(alpha, color, fade)
    super:init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.alpha = alpha or 1
    self.timer = Timer()
    self:addChild(self.timer)
    if fade then
        self.alpha = 0
        self.timer:tween(fade, self, {alpha = alpha})
    end
    self.layer = BATTLE_LAYERS["top"]
    self.light_color = color or {1,1,1}

    self.lights = {}
    -- to add light sources to the lighting overlay, you add tables of data to this table
    -- each table can define the following properties:
        -- x, y: position of the light source
        -- radius: radius of the light source
        -- color: optional color of the light source, defaulting to the color defined by init if not specified
        -- alpha: optional alpha of the light source, defaulting to 1
    -- for x, y, and radius, instead of giving a number, you can give a function that returns a number that gets called each frame
    -- useful if the value changes over time
end

function Lighting:draw()
    super:draw(self)
    local canvas = Draw.pushCanvas(SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1-self.alpha, 1-self.alpha, 1-self.alpha)
    love.graphics.rectangle("fill",0,0,SCREEN_WIDTH,SCREEN_HEIGHT)
    love.graphics.setBlendMode("add")
    for _,light in pairs(self.lights) do
        local color = light.color or self.light_color
        local alpha = light.alpha or 1
        local x, y, rad = light.x, light.y, light.radius
        if type(x) == "function" then
            x = x()
        end
        if type(y) == "function" then
            y = y()
        end
        if type(rad) == "function" then
            rad = rad()
        end

        love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha/2))
        love.graphics.circle("fill", x, y, rad)
        love.graphics.setColor(Utils.lerp({0,0,0}, color, alpha))
        love.graphics.circle("fill", x, y, rad*0.75)
    end
    love.graphics.setBlendMode("alpha")
    Draw.popCanvas()

    love.graphics.setBlendMode("multiply", "premultiplied")
    love.graphics.setColor(1,1,1)
    love.graphics.draw(canvas)
    love.graphics.setBlendMode("alpha")
end

return Lighting