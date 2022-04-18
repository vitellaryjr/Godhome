local BossEncounter, super = Class(Encounter)

function BossEncounter:init()
    super:init(self)
    self.default_xactions = false
    PALETTE["action_strip"] = {0.1, 0.1, 0.15}
    self.music = nil

    self.difficulty = 1
    -- 1 = attuned
    -- 2 = fake ascended (used for p5)
    -- 3 = ascended (more health + double damage)
    -- 4 = radiant (more health + instakill)

    self.bosses = {}
    -- used to keep track of the important enemies
    -- enemies not in this table don't count towards finishing the encounter

    self.player_proj_hb = Hitbox(Game.battle, 116,166,20,40)

    -- list of currently active spells
    self.spells = {}
end

function BossEncounter:onBattleStart()
    super:onBattleStart(self)
    if Game:getFlag("bindings", {}).hp then
        local player = Game.battle:getPartyByID("knight").chara
        player.health = math.min(player.health, 40)
    end
    if not Game:getFlag("in_pantheon") then
        self:playMusic()
    end
    local unlocked = Game:getFlag("hall_unlocked", {})
    unlocked[self.id] = true
    Game:setFlag("hall_unlocked", unlocked)
end

function BossEncounter:onTurnStart()
    self.spells = {}
end

function BossEncounter:createSoul(x, y)
    return NailSoul(x, y)
end

function BossEncounter:draw()
    super:draw(self)
    if DEBUG_RENDER then
        self.player_proj_hb:draw(1,0,0)
    end
end

function BossEncounter:getEncounterText()
    local knight = Game:getPartyMember("knight")
    if not Game:getFlag("taught_healing", false) and knight.health < knight.stats.health then
        Game:setFlag("taught_healing", true)
        return "* Hold "..Input.getText("cancel").." during a wave to spend\nTP to heal!"
    end
    return super:getEncounterText(self)
end

function BossEncounter:removeBoss(boss)
    Utils.removeFromTable(self.bosses, boss)
    Utils.removeFromTable(Game.battle.enemies, boss)
    if not Game.battle.dead_enemies then
        Game.battle.dead_enemies = {boss}
    else
        table.insert(Game.battle.dead_enemies, boss)
    end
end

function BossEncounter:dreamEnd(instant)
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
    end

    Game.battle:setState("DREAM_END")
    Game.battle:resetAttackers()
    if Game.battle.battle_ui.encounter_text then
        Game.battle.battle_ui.encounter_text:setAdvance(false)
    end
    Game.battle.timer:after(instant and 0 or 1.8, function() -- wait for enemy death animation
        if Game:getFlag("in_pantheon", false) then
            local series = Game:getFlag("pantheon_series", {})
            if #series == 0 then
                Assets.playSound("pantheon/transition_long")
                Game.battle:addChild(ParticleEmitter(0,80, SCREEN_WIDTH,SCREEN_HEIGHT + 80, {
                    layer = 10000,
                    shape = "circle",
                    color = {1,1,1},
                    blend = "add",
                    size = {8,32},
                    speed_y = function(p) return Utils.clampMap(p.size, 8,32, -2,-12) end,
                    speed_y_var = 1,
                    fade_in = 0.1,
                    grow = 0.1,
                    shrink = 0.1,
                    shrink_after = 0.5,
                    amount = {6,8},
                    every = 0.3,
                }))
                Game.stage:addChild(ScreenFade({1,1,1}, 0, 1, 2, function(fade)
                    Game.stage.timer:after(0.5, function()
                        Mod:pantheonTransition(fade)
                    end)
                end))
            else
                Assets.playSound("pantheon/transition_short")
                Game.stage:addChild(ScreenFade({1,1,1}, 0, 1, 1.2, function(fade)
                    Game.stage.timer:after(0.5, function()
                        Mod:pantheonTransition(fade)
                    end)
                end))
            end
        else
            Assets.playSound("pantheon/transition_short")
            Game.stage:addChild(ScreenFade({1,1,1}, 0, 1, 1.2, function(fade)
                Game.stage.timer:after(0.5, function()
                    self:stopMusic()
                    Game.battle:returnToWorld()
                    fade:fadeOutAndRemove()
                end)
            end))
        end
    end)
end

function BossEncounter:playMusic(music, volume)
    -- self:stopMusic()
    music = music or self.pantheon_music
    volume = volume or 1
    self.pantheon_music = music
    if type(music) == "table" then
        self.pantheon_music_source = {}
        for _,track in ipairs(music) do
            local source = Music()
            source:play(track, volume)
            table.insert(self.pantheon_music_source, source)
        end
    else
        self.pantheon_music_source = Music()
        self.pantheon_music_source:play(music, volume)
    end
end

function BossEncounter:stopMusic()
    if self.pantheon_music_source then
        if self.pantheon_music_source[1] then
            for _,source in ipairs(self.pantheon_music_source) do
                source:stop()
            end
        else
            self.pantheon_music_source:stop()
        end
        self.pantheon_music_source = nil
    end
end

return BossEncounter