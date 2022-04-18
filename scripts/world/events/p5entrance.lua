local Entrance, super = Class(InteractScript)

function Entrance:init(data)
    super:init(self, "enter_p5", data.x, data.y)

    self:setSprite("tilesets/doors/p5_entrance")
    self:setOrigin(0.5, 1)

    self:setHitbox(24,0, 152,200)
    self.solid = true

    self.pantheon = 5
    self:addChild(PantheonGem(self.pantheon, 100, 50, {
        {-33.5,16.5},
        {-23.5,3.5},
        {23.5,3.5},
        {33.5,16.5},
    }))

    self:addChild(ParticleEmitter(86, 148, 24, 20, {
        layer = 1,
        shape = "circle",
        color = {0,0,0},
        alpha = {0.7,1},
        size = {2,6},
        speed_y = {-1,-2},
        shrink = {0.01,0.05},
        shrink_after = {1,1.2},
        amount = {2,3},
        every = 0.2,
        parent = true,
    }))
    self:addChild(ParticleEmitter(86, 74, 24, 20, {
        layer = 1,
        shape = "circle",
        color = {0,0,0},
        alpha = {0.7,1},
        size = {2,6},
        speed_y = {1,2},
        shrink = {0.01,0.05},
        shrink_after = {1,1.2},
        amount = {2,3},
        every = 0.2,
        parent = true,
    }))
    self:addChild(ParticleEmitter(86, 148, 24, 20, {
        layer = 1,
        shape = "circle",
        color = {0,0,0},
        alpha = {0.3,0.5},
        rotation = 0,
        width = {4,6},
        height = {32,40},
        speed_y = {-0.5,-0.8},
        grow_x = 0.02,
        shrink_x = 0.02,
        shrink_after = {2,3},
        amount = 1,
        every = 0.5,
        parent = true,
    }))
    self:addChild(ParticleEmitter(86, 74, 24, 20, {
        layer = 1,
        shape = "circle",
        color = {0,0,0},
        alpha = {0.3,0.5},
        rotation = 0,
        width = {4,6},
        height = {32,40},
        speed_y = {0.5,0.8},
        grow_x = 0.02,
        shrink_x = 0.02,
        shrink_after = {2,3},
        amount = 1,
        every = 0.5,
        parent = true,
    }))
end

return Entrance