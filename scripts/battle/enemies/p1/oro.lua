local Oro, super = Class("boss")

function Oro:init()
    super:init(self)

    self.name = "Oro"
    self:setActor("p1/nailmaster")

    self.max_health = 180
    self.health = 180

    self.waves = {
        "p1/nailmasters/naildrop",
        "p1/nailmasters/dashslash",
    }

    self.text = {
        "* Fighting at the edge of the world.",
        "* Those who do not share their\nstrength will never learn.",
        "* Those who do not share their Geo\nwill never learn.",
    }
end

function Oro:onDefeat(damage, battler)
    local en = Game.battle.encounter
    if en.phase == 1 then
        en.phase = 2
        if Game.battle.battle_ui.encounter_text then
            Game.battle.battle_ui.encounter_text:setAdvance(false)
        end
        Game.battle:startCutscene("spawnmato")
        Game.battle:resetAttackers()
    elseif en.phase == 2 then
        en.phase = 3
        self:setAnimation("down")
        self.sprite.shake_x = 9
        en:removeBoss(self)
    elseif en.phase == 3 then
        en.phase = 4
        self.overlay_sprite:setAnimation("down")
        super:onDefeat(self, damage, battler)
        en.mato:onDefeat()
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

return Oro