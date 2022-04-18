local Blob, super = Class(Bullet)

function Blob:init(x, y, count)
    super:init(self, x, y)
    self.layer = BATTLE_LAYERS["bullets"] + 1
    self.collider = CircleCollider(self, 0,0, 5)
    self.collidable = false

    self.count = count
    self.radius = 0
    self.bullets = {}
end

function Blob:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:tween(0.2, self, {radius = 7.5})

    self.wave.timer:after(0.5, function()
        for i=1,self.count do
            local angle = i * (math.pi*2/self.count) + self.rotation
            local bullet = self.wave:spawnBullet("battle/p3/hiveknight/spike", self.x, self.y)
            bullet.collidable = false
            bullet.rotation = angle
            bullet.physics = {
                speed = 5,
                friction = 1,
                match_rotation = true,
            }
            table.insert(self.bullets, bullet)
        end
        self.wave.timer:after(0.1, function()
            self.collidable = true
        end)
        self.wave.timer:after(0.3, function()
            self.shaking = true
        end)
    end)
end

function Blob:draw()
    super:draw(self)
    love.graphics.setColor(1,1,1)
    local x, y = 0, 0
    if self.shaking then
        x, y = love.math.random(-1,1), love.math.random(-1,1)
    end
    love.graphics.circle("fill", x, y, self.radius)
end

function Blob:eject()
    --[[ Game.battle:addChild(ParticleEmitter(self.x, self.y, {
        shape = "circle",
        width = {8,10},
        height = {4,6},
        angle = function(p) return p.rotation end,
        match_rotation = true,
        gravity = 0.2,
        amount = {4,5},
    })) ]]
    for _,bullet in ipairs(self.bullets) do
        bullet.collidable = true
        bullet.physics = {
            speed = 8,
            match_rotation = true,
        }
    end
    self:remove()
end

return Blob