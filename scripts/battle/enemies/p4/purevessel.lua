local Vessel, super = Class("boss")

function Vessel:init()
    super:init(self)

    self.name = "Pure Vessel"
    self:setActor("p4/purevessel")

    self.max_health = 1000
    self.health = 1000

    self.waves = {
        "p4/purevessel/daggers",
        "p4/purevessel/swords",
        "p4/purevessel/dagger_explosion",
        "p4/purevessel/focus",
    }

    self.text = {
        "* No mind to think.",
        "* No will to break.",
        "* No voice to cry suffering.",
        "* No cost too great.",
        "* Born of God and Void.",
    }

    self.double_damage = true
end

function Vessel:onDefeat(...)
    Game.battle.encounter:stopMusic()
    self.hurt_timer = -1
    self:toggleOverlay(true)
    if self.actor.animations["defeat"] then
        self.overlay_sprite:setAnimation("defeat")
    else
        self.overlay_sprite:setAnimation("hurt")
    end
    self.encounter:removeBoss(self)
    if #self.encounter.bosses == 0 then
        self.encounter:dreamEnd()
    end
    Game.battle.timer:after(0.7, function()
        local mask = ColorMaskFX({0,0,0}, 0)
        self:addFX(mask, "dream_disappear")
        Assets.playSound("bosses/boss_defeat")
        Game.battle.timer:tween(0.2, mask, {amount = 1}, "linear", function()
            local x, y = self.overlay_sprite:getScreenPos()
            local w = self.overlay_sprite.width*self.scale_x
            local h = self.overlay_sprite.height*self.scale_y
            Game.battle:addChild(ParticleEmitter(x, y, w, h, {
                layer = "battlers",
                color = {0,0,0},
                alpha = {0.7,1},
                size = {4,8},
                speed_y = {1,2},
                gravity = 0.05,
                shrink = 0.01,
                amount = 50,
            }))
            Game.battle.timer:tween(0.5, self.overlay_sprite, {alpha = 0}, "linear", function()
                self:remove()
            end)
        end)
    end)
end

return Vessel