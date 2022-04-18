local Mato, super = Class("boss")

function Mato:init()
    super:init(self)

    self.name = "Mato"
    self:setActor("p1/nailmaster")

    self.max_health = 500
    self.health = 500

    self.waves = {
        "p1/nailmasters/naildrop",
        "p1/nailmasters/cycloneslash",
    }

    self.text = {
        "* Winds howl by.",
        "* Mato sits down and meditates.",
        "* The world is spinning, spinning.\n* ...no, it's just Mato.",
    }
end

function Mato:onDefeat(damage, battler)
    local en = Game.battle.encounter
    if en.phase == 2 then
        en.phase = 3
        self:setAnimation("down")
        self.sprite.shake_x = 9
        en:removeBoss(self)
    elseif en.phase == 3 then
        en.phase = 4
        self.overlay_sprite:setAnimation("down")
        super:onDefeat(self, damage, battler)
        en.oro:onDefeat()
    else
        self.overlay_sprite:setAnimation("down")
        self.hurt_timer = -1
        self:toggleOverlay(true)
        Game.battle.encounter:stopMusic()
        Game.battle.timer:after(0.7, function()
            self:dreamDisappear()
        end)
    end
end

return Mato