local Hall, super = Class(Map)

function Hall:loadObject(name, data)
    if name == "void_ps" then
        local ps = ParticleEmitter(data.x, data.y, data.width, data.height, {
            layer = Game.world:parseLayer("objects_ps"),
            shape = "circle",
            color = {0,0,0},
            alpha = {0.7,1},
            size = {6,10},
            speed_y = {-0.5,-1},
            grow = 0.01,
            shrink = {0.01,0.05},
            shrink_after = {2,4},
            amount = {2,3},
            every = 2,
        })
        Game.world:addChild(ps)
        return nil
    end
    return super:loadObject(self, name, data)
end

return Hall