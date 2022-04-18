local SoulTyrant, super = Class("boss")

function SoulTyrant:init()
    super:init(self)

    self.name = "Soul Tyrant"
    self:setActor("p4/soultyrant")

    self.max_health = 700
    self.health = 700

    self.waves = {
        "p4/soultyrant/1/dive",
        "p4/soultyrant/1/orb_chase",
        "p4/soultyrant/1/orb_ring",
    }

    self.text = {
        "* Something whispers inside you.",
        "* The soul in the air is suffocating.",
    }

    self.phase = 1
    self.turn = 1
end

function SoulTyrant:onDefeat(damage, battler)
    if self.phase == 1 then
        self.phase = 2
        self.hurt_timer = -1
        self:toggleOverlay(true)
        Game.battle.timer:after(0.7, function()
            local mask = ColorMaskFX({1,1,1}, 0)
            self:addFX(mask, "fadeout")
            Game.battle.timer:tween(0.1, mask, {amount = 1}, "linear", function()
                self:dreamDisappear(true)
            end)
        end)
        Game.battle:resetAttackers()
        if Game.battle.arena then
            -- copied from onWavesDone
            Game.battle:returnSoul()
    
            for _,wave in ipairs(Game.battle.waves) do
                wave:onEnd()
                wave:clear()
                wave:remove()
            end
    
            if Game.battle.arena then
                Game.battle.arena:remove()
                Game.battle.arena = nil
            end
    
            Game.battle.waves = {}
            Game.battle:setState("DEFENDINGEND")
        end
        local cutscene = Game.battle:startCutscene("soulmasterfakeout")
        cutscene:after(function()
            self.max_health = 500
            self.health = 500
            Game.battle.encounter:onDialogueEnd()
        end)
    else
        super:onDefeat(self, damage, battler)
    end
end

function SoulTyrant:getNextWaves()
    if self.phase == 1 then
        return super:getNextWaves(self)
    elseif self.phase == 2 then
        self.turn = self.turn + 1
        if self.turn%2 == 0 then
            return {"p4/soultyrant/2/dives"}
        else
            return {"p4/soultyrant/2/orbs"}
        end
    end
end

return SoulTyrant