local SoulMaster, super = Class("boss")

function SoulMaster:init()
    super:init(self)

    self.name = "Soul Master"
    self:setActor("p2/soulmaster")

    self.max_health = 500
    self.health = 500

    self.text = {
        "* Organs blare in the background.",
        "* The air is thick with soul.",
        "* Something whispers all around you.",
    }

    self.phase = 1
    self.turn = 1
end

function SoulMaster:onDefeat(damage, battler)
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
        if Game.battle.battle_ui.encounter_text then
            Game.battle.battle_ui.encounter_text:setAdvance(false)
        end
        local cutscene = Game.battle:startCutscene("soulmasterfakeout")
        cutscene:after(function()
            self.max_health = 300
            self.health = 300
            Game.battle.encounter:onDialogueEnd()
            --[[ Game.battle:setWaves{"p2/soulmaster/2/dives"}
            self.selected_wave = Game.battle.waves[1]
            Game.battle:setState("DEFENDING") ]]
        end, true)
    else
        super:onDefeat(self, damage, battler)
    end
end

function SoulMaster:getNextWaves()
    if self.phase == 1 then
        return {
            "p2/soulmaster/1/orb_chase",
            "p2/soulmaster/1/orb_ring",
            "p2/soulmaster/1/dive",
        }
    elseif self.phase == 2 then
        self.turn = self.turn + 1
        if self.turn%2 == 0 then
            return {"p2/soulmaster/2/dives"}
        else
            return {"p2/soulmaster/2/orbs"}
        end
    end
end

return SoulMaster