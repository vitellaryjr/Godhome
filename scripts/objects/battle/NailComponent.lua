local NailComponent, super = Class(Object)

function NailComponent:init()
    super:init(self, 0,0)

    self.knockback = true
end

function NailComponent:hit(source) end

function NailComponent:knockbackAngle(source)
    return Utils.angle(self.x, self.y, source.x, source.y)
end

return NailComponent