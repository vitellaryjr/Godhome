local Soul, super = Class("ordeal/zotebase")

function Soul:init(x, y)
    super:init(self, x, y, "battle/ordeal/soul")
    self.sprite:play(0.2, true)
    self:setHitbox(3,7, 6,18)
    self.health = 60
    self.knockback = 4

    self.oy = self.y
    self.sine = Utils.random(math.pi*2)
end

function Soul:onAdd(parent)
    super:onAdd(self, parent)
    self:teleport(self.x, self.y)
    local timer = Timer()
    self:addChild(timer)
    timer:script(function(wait)
        wait(2)
        while true do
            if love.math.random() < 0.5 then
                self:attack()
            else
                self:teleport()
            end
            wait(Utils.random(1.5,2))
        end
    end)
end

function Soul:update()
    super:update(self)
    self.sine = self.sine + DT
    self.y = self.oy + math.sin(self.sine*3)*5
    if self.curr_knockback > 0 then
        self.oy = self.oy + self.curr_knockback*math.sin(self.knockback_dir)*DTMULT
    end
    local soul = Game.battle.soul
    if soul.x < self.x then
        self.scale_x = -2
    else
        self.scale_x = 2
    end
end

function Soul:attack()
    self:setSprite("battle/ordeal/soul_charge", 0.1, true)
    local mask = ColorMaskFX({1,1,1}, 0)
    self:addFX(mask)
    self.wave.timer:tween(0.6, mask, {amount = 0.5}, "linear", function()
        if not self.stage then return end
        self:removeFX(mask)
        self:setSprite("battle/ordeal/soul", 0.2, true)
        local soul = Game.battle.soul
        local x, y = self.x, self.y
        local orb = self.wave:spawnBullet("common/soulorb", x, y, 2, Utils.angle(x, y, soul.x, soul.y), 0.05, 8)
        orb:setScale(1.5)
    end)
end

function Soul:teleport(x, y)
    local arena, soul = Game.battle.arena, Game.battle.soul
    if not x and not y then
        x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
        while math.abs(soul.x - x) < 50 and math.abs(soul.y - y) < 50 do
            x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
        end
    end
    self:setPosition(x, y)
    self.oy = y
    local mask = ColorMaskFX({1,1,1}, 1)
    self:addFX(mask)
    self.wave.timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self:removeFX(mask)
    end)
    Game.battle:addChild(ParticleEmitter(x, y, {
        shape = {"circle", "arc"},
        blend = "add",
        spin_var = 0.5,
        scale = {0.6,0.8},
        physics = {
            speed = {4,6},
            friction = 0.2,
        },
        fade = 0.02,
        shrink = 0.1,
        shrink_after = 0.2,
        amount = {4,5},
    }))
end

return Soul