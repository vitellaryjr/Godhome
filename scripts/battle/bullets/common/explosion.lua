local Explosion, super = Class(Bullet)

function Explosion:init(x, y, radius)
    super:init(self, x, y)
    self:setScale(1, 1)
    self.collider = CircleCollider(self, 0,0, radius)
    self.double_damage = true
    Game.battle.shake = 4

    local num = math.floor(radius/5)
    for i=1,num do
        local x, y = (radius*0.9)*math.cos(i*math.pi/(num/2)), (radius*0.9)*math.sin(i*math.pi/(num/2))
        self:addChild(ParticleEmitter(x,y, {
            shape = "circle",
            color = {1,1,1},
            alpha = 1,
            scale = 0.7,
            angle = function(p) return p.rotation end,
            dist = {0,radius*0.2},
            speed = 0.3,
            speed_var = 0.1,
            shrink = 0.05,
            shrink_after = 0.4,
            shrink_after_var = 0.1,
            amount = {radius/5, radius/4},
        }))
    end
    num = Utils.round(num*0.6)
    for i=1,num do
        local x, y = (radius*0.4)*math.cos(i*math.pi/(num/2)), (radius*0.4)*math.sin(i*math.pi/(num/2))
        self:addChild(ParticleEmitter(x,y, {
            shape = "circle",
            color = {1,1,1},
            alpha = 1,
            scale = 0.7,
            angle = function(p) return p.rotation end,
            dist = {0,radius*0.4},
            speed = 0.3,
            speed_var = 0.1,
            shrink = 0.05,
            shrink_after = 0.4,
            shrink_after_var = 0.1,
            amount = {radius/8, radius/7},
        }))
    end
    Assets.playSound("explosion")
end

function Explosion:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:after(0.4, function()
        self:remove()
    end)
end

return Explosion