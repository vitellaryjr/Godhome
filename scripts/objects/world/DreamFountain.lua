local Fountain, super = Class(Object)

function Fountain:init(x, y)
    super:init(self, x, y)
    self.parallax_x = 0.3
    self.parallax_y = 0.3
    self.sprite = Sprite("tilesets/dream_fountain", 0, 0)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:play(0.15, true)
    self.sprite.wrap_texture_y = true
    self:addChild(self.sprite)
    Game.world:addChild(ParticleEmitter(x - 60, y - 900, 120, 900, {
        layer = Game.world:parseLayer("dream_ps"),
        path = "battle/misc/dream",
        shape = {"med_a", "med_b"},
        color = {1,1,1},
        alpha = 1,
        blend = "add",
        fade_in = 0.02,
        fade = 0.02,
        fade_after = {3,4},
        speed_y = {-0.2,-0.8},
        spin_var = math.rad(1),
        amount = 3,
        every = 3,
        init = function(p)
            p.parallax_x = 0.3
            p.parallax_y = 0.3
        end,
    }))
    Game.world:addChild(ParticleEmitter(x - 60, y - 900, 120, 900, {
        layer = Game.world:parseLayer("dream_ps"),
        path = "battle/misc/dream",
        shape = {"small_a", "small_b"},
        color = {1,1,1},
        alpha = 0.1,
        blend = "add",
        fade_in = 0.001,
        fade = 0.001,
        fade_after = {2,3},
        speed_y = {-2,-3},
        spin_var = math.rad(1),
        amount = 20,
        every = 1,
        init = function(p)
            p.parallax_x = 0.3
            p.parallax_y = 0.3
        end,
    }))
end

return Fountain