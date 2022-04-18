local Gate, super = Class(Event)

function Gate:init(data)
    super:init(self, data)
    self.solid = true

    self.sprites = {}
    for i=1,math.ceil(data.height/40) do
        local sprite = Sprite("tilesets/gate", data.width/2, i*40)
        sprite.layer = i
        sprite:setOrigin(0.5, 1)
        sprite:setScale(2)
        self:addChild(sprite)
        table.insert(self.sprites, sprite)
    end

    self.gate_id = data.properties.id
end

function Gate:disappear()
    local mask = ColorMaskFX({1,1,1}, 0)
    self:addFX(mask)
    Assets.playSound("gate_glow")
    Game.world.timer:tween(2, mask, {amount = 1}, "linear", function()
        Game.world:spawnObject(ParticleEmitter(self.x, self.y, self.width, self.height, {
            layer = Game.world:parseLayer("objects_ps"),
            color = {1,0.9,0.75},
            alpha = {0.7,1},
            size = {8,12},
            blend = "add",
            speed_y = {-5,5},
            shrink = 0.01,
            amount = 30,
        }))
        Assets.playSound("gate_open")
        self:remove()
    end)
    return function() return self.stage == nil end
end

return Gate