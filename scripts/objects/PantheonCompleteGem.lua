local Gem, super = Class(Object)

function Gem:init()
    super:init(self, 320, 220)
    self.layer = 2000
    self.alpha = 1

    self.gem = Sprite("cutscene/pantheon_end/gem_notch", 0,0)
    self.gem.inherit_color = true
    self.gem:setOrigin(0.5, 0.5)
    self:addChild(self.gem)

    self.bindings = {}
    self.bindings.magic = Sprite("cutscene/pantheon_end/binding_notch", -80,-40)
    self.bindings.magic.inherit_color = true
    self.bindings.magic:setOrigin(0.5, 0.5)
    self:addChild(self.bindings.magic)
    self.bindings.hp = Sprite("cutscene/pantheon_end/binding_notch", -50,-80)
    self.bindings.hp.inherit_color = true
    self.bindings.hp:setOrigin(0.5, 0.5)
    self:addChild(self.bindings.hp)
    self.bindings.tp = Sprite("cutscene/pantheon_end/binding_notch", 50,-80)
    self.bindings.tp.inherit_color = true
    self.bindings.tp:setOrigin(0.5, 0.5)
    self:addChild(self.bindings.tp)
    self.bindings.nail = Sprite("cutscene/pantheon_end/binding_notch", 80,-40)
    self.bindings.nail.inherit_color = true
    self.bindings.nail:setOrigin(0.5, 0.5)
    self:addChild(self.bindings.nail)

    self.timer = Timer()
    self:addChild(self.timer)
    self.timer:tween(0.2, self, {scale_x = 2, scale_y = 2, alpha = 1}, "linear", function()
        self.timer:during(0.3, function(dt)
            self:setPosition(320 + love.math.random(-2,2), 220 + love.math.random(-2,2))
        end, function()
            self:setPosition(320, 220)
        end)
    end)
end

function Gem:activateBinding(name)
    local binding = self.bindings[name]
    self.timer:script(function(wait)
        local mask = ColorMaskFX({1,1,1}, 0)
        binding:addFX(mask)
        self.timer:tween(0.1, mask, {amount = 1})
        wait(0.1)
        local fade = ScreenFade({1,1,1}, 0.5, 0, 1)
        fade.layer = 2100
        Game.world:addChild(fade)
        binding:setTexture("cutscene/pantheon_end/binding_"..name)
        self.timer:tween(0.5, mask, {amount = 0}, "linear", function()
            binding:removeFX(mask)
        end)
    end)
end

function Gem:activateGem()
    self.timer:script(function(wait)
        local fade = ScreenFade({1,1,1}, 0.8, 0, 1)
        fade.layer = 2100
        Game.world:addChild(fade)
        local gem_path = "gem"
        local bindings = Game:getFlag("bindings", {})
        if bindings.hp and bindings.nail and bindings.tp and bindings.magic then
            gem_path = gem_path .. "_bindings"
            for name,binding in pairs(self.bindings) do
                binding:setTexture("cutscene/pantheon_end/binding_"..name.."_glow")
            end
        end
        if Game:getFlag("hitless", false) then
            gem_path = gem_path .. "_hitless"
            self.timer:after(0.8, function()
                self:addChild(ParticleEmitter(0,0, {
                    layer = 2050,
                    shape = "circle",
                    color = {0,0,0},
                    alpha = {0.7,1},
                    size = {16,32},
                    speed_x = {-0.5,0.5},
                    speed_y = {-1,-2},
                    fade_in = 0.05,
                    shrink = {0.01,0.05},
                    shrink_after = {1,2},
                    amount = 1,
                    every = {0.3,0.5},
                }))
            end)
        end
        if gem_path == "gem" then
            gem_path = "gem_complete"
        end
        self.gem:setTexture("cutscene/pantheon_end/"..gem_path)
        Assets.playSound("pantheon/victory")
        local mask = ColorMaskFX({1,1,1}, 1)
        self.gem:addFX(mask)
        self.timer:tween(1, mask, {amount = 0}, "linear", function()
            self.gem:removeFX(mask)
        end)
    end)
end

return Gem