local Slash, super = Class(Bullet)

function Slash:init(x, y, corner)
    super:init(self, x, y)
    local points = {{0, 0}, {70, 0}, {0, 70}}
    self.collider = PolygonCollider(self, points)
    self.collidable = false
    self.rotation = (corner-1)*math.pi/2
    self.tp = 3.2
    self.double_damage = true

    self:setSprite("battle/p2/sheo/glow")
    self.sprite.alpha = 0
    self.sprite.graphics = {
        fade_to = 1,
        fade = 0.08,
    }
    self.ps = ParticleAbsorber(0, 0, {
        layer = BATTLE_LAYERS["above_arena"],
        shape = "circle",
        angle = {self.rotation,self.rotation + math.pi/2},
        size = {6,8},
        dist = {35,105},
        shrink = 0.05,
        shrink_after = {0.3,0.4},
        amount = {2,3},
        every = 0.1,
        mask = true,
    })
    self:addChild(self.ps)

    self.phase = 1
    self.slow = slow
end

function Slash:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        wait(0.8)
        Game.battle:addChild(ScreenFade({1,1,1}, 0.2, 0, 0.1))
        self.ps:remove()
        Game.battle.shake = 4
        self:setSprite("battle/p2/sheo/greatslash", 0.1, true)
        self.collidable = true
        self.phase = 2
        wait(0.1)
        self.collidable = false
        self:setSprite("battle/p2/sheo/greatslash_end", 0.05, false, function()
            self:remove()
        end)
    end)
end

function Slash:draw()
    if self.phase == 1 then
        love.graphics.setColor(1,1,1, self.sprite.alpha/10)
        local points = {}
        for _,p in ipairs(self.collider.points) do
            table.insert(points, p[1])
            table.insert(points, p[2])
        end
        love.graphics.polygon("fill", points)
    end
    super:draw(self)
end

return Slash