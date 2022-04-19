function Mod:init()
    self:loadHooks()
    self.encounters = {
        "p1/vengeflyking",
        "p1/gruzmother",
        "p1/falseknight",
        "p1/mosscharger",
        "p1/hornet",
        "p1/gorb",
        "p1/dungdefender",
        "p1/soulwarrior",
        "p1/broodingmawlek",
        "p1/nailmasters",
        "p2/xero",
        "p2/crystalguardian",
        "p2/soulmaster",
        "p2/oblobbles",
        "p2/mantislords",
        "p2/marmu",
        "p2/nosk",
        "p2/flukemarm",
        "p2/brokenvessel",
        "p2/sheo",
        "p3/hiveknight",
        "p3/elderhu",
        "p3/collector",
        "p3/godtamer",
        "p3/grimm",
        "p3/galien",
        "p3/greyprince",
        "p3/uumuu",
        "p3/hornet2",
        "p3/sly",
        "p4/enragedguardian",
        "p4/lostkin",
        "p4/noeyes",
        "p4/traitorlord",
        "p4/whitedefender",
        "p4/failedchamp",
        "p4/markoth",
        "p4/watcherknights",
        "p4/soultyrant",
        "p4/purevessel",
        "p5/wingednosk",
        "p5/sisters",
        "p5/kristalguardian",
        "p5/nkg",
        "p5/radiance",
    }
end

function Mod:loadHooks()
    -- extra functions
    function math.modi(v, i)
        while v > i do
            v = v - i
        end
        while v < 0 do
            v = v + i
        end
        return v
    end

    -- bindings stuff
    Utils.hook(TensionBar, "onAdd", function(orig, tpbar, parent)
        orig(tpbar, parent)
        if Game:getFlag("bindings", {}).tp then
            tpbar:remove()
            Game.battle.tension_bar = BoundTensionBar(tpbar.x, tpbar.y)
            parent:addChild(Game.battle.tension_bar)
        end
    end)
    Utils.hook(ActionBoxDisplay, "init", function(orig, box, x, y)
        orig(box, x, y, index, battler)
        if Game:getFlag("bindings", {}).hp then
            box.hp_bind = Sprite("ui/hp_bind", 162, 22 - box.actbox.data_offset)
            box.hp_bind:setScale(2)
            box:addChild(box.hp_bind)
        end
    end)
    Utils.hook(ActionBoxDisplay, "update", function(orig, box, dt)
        orig(box, dt)
        if Game:getFlag("bindings", {}).hp then
            box.hp_bind.y = 20 - box.actbox.data_offset
        end
    end)
    Utils.hook(PartyBattler, "heal", function(orig, battler, amount)
        if Game:getFlag("bindings", {}).hp then
            if battler.chara.health + amount >= 40 then
                battler.chara.stats.health = 40
                orig(battler, amount)
                battler.chara.stats.health = 90
            else
                orig(battler, amount)
            end
        else
            orig(battler, amount)
        end
    end)
    Utils.hook(EnemyBattler, "getAttackTension", function(orig, enemy, points)
        if Game:getFlag("bindings", {}).magic then
            return orig(enemy, points) / 2
        else
            return orig(enemy, points)
        end
    end)
    Utils.hook(Soul, "init", function(orig, soul, x, y)
        orig(soul, x, y)
        if Game:getFlag("bindings", {}).magic then
            soul.graze_collider.radius = 18
        end
    end)

    -- damage / health scaling based on difficulty
    -- also detecting hitless
    Utils.hook(PartyBattler, "hurt", function(orig, battler, amount, exact)
        Game:setFlag("hitless", false)
        local diff = Game.battle.encounter.difficulty or 1
        if diff <= 2 then -- attuned, fake ascended
            orig(battler, amount, exact)
        elseif diff == 3 then -- ascended
            orig(battler, amount*2, exact)
        elseif diff == 4 then -- radiant
            battler:down()
        end
    end)
    Utils.hook(Encounter, "onBattleStart", function(orig, encounter)
        orig(encounter)
        local diff = encounter.difficulty or 1
        if diff > 2 then -- ascended, radiant
            for _,enemy in ipairs(Game.battle.enemies) do
                if enemy.asc_health then
                    enemy.max_health = enemy.asc_health
                    enemy.health = enemy.asc_health
                else
                    enemy.max_health = enemy.max_health*2
                    enemy.health = enemy.health*2
                end
            end
        end
    end)

    -- disable destroy_on_hit by default, add double_damage effects
    Utils.hook(Bullet, "init", function(orig, bullet, x, y, texture)
        orig(bullet, x, y, texture)
        bullet.destroy_on_hit = false
        bullet.double_damage = nil
    end)
    Utils.hook(Bullet, "onAdd", function(orig, bullet, parent)
        if bullet.attacker and bullet.attacker.double_damage and bullet.double_damage ~= false then
            bullet.double_damage = true
        end
        orig(bullet, parent)
    end)
    Utils.hook(Bullet, "getDamage", function(orig, bullet)
        if bullet.double_damage then
            return orig(bullet)*1.5 -- 2x is too much
        else
            return orig(bullet)
        end
    end)
    Utils.hook(Bullet, "onDamage", function(orig, bullet, soul)
        orig(bullet, soul)
        if bullet.double_damage then
            Game.battle.shake = 8
            local i = 0
            Game.battle:addChild(ParticleEmitter(soul.x, soul.y, {
                layer = BATTLE_LAYERS["above_soul"],
                shape = "circle",
                color = {0,0,0},
                scale_var = 0.1,
                speed = 2,
                fade = 0.1,
                fade_after = 0.1,
                angle = function(p)
                    i = i + math.pi/10
                    return i
                end,
                angle_var = 0.15,
                dist = 32,
                amount = 20,
            }))
            local fx = Sprite("battle/misc/heavy_damage_ui")
            fx.layer = BATTLE_LAYERS["top"] + 1000
            fx.alpha = 1
            Game.battle:addChild(fx)
            fx:fadeOutAndRemove(0.1)
        end
    end)

    -- knight flashing red when fury is active
    Utils.hook(PartyBattler, "init", function(orig, battler, chara, x, y)
        orig(battler, chara, x, y)
        battler.fury_ps = ParticleEmitter(battler.width/2, battler.height/2 + 7, {
            auto = false,
            layer = "below_battlers",
            shape = "circle",
            color = {1, 0.2, 0.2},
            alpha = 0.15,
            size = {24,32},
            physics = {
                speed = {2,3},
                friction = 0.05,
            },
            fade = 0.03,
            fade_after = 0.2,
            amount = {2,3},
            every = 0.2,
        })
        battler:addChild(battler.fury_ps)
        battler.fury_mask = ColorMaskFX({1,0.2,0.2}, 0)
        battler:addFX(battler.fury_mask)
        battler.fury_sine = 0
    end)
    Utils.hook(PartyBattler, "update", function(orig, battler, dt)
        orig(battler, dt)
        local player = battler.chara
        if player:getArmor(2).id == "armors/fury" then
            if player.health <= 15 then
                battler.fury_ps.data.auto = true
                battler.fury_sine = (battler.fury_sine + dt) % (math.pi)
            else
                battler.fury_ps.data.auto = false
                if battler.fury_sine > 0 then
                    battler.fury_sine = (battler.fury_sine + dt)
                    if battler.fury_sine > math.pi then
                        battler.fury_sine = 0
                    end
                end
            end
            battler.fury_mask.amount = math.abs(math.sin(battler.fury_sine*2)) * 0.2
        end
    end)

    -- for dark encounters, add light sources
    self.light_indexes = {}
    local function addLight(type, x, y, r, fade)
        self.light_indexes[type] = #Game.battle.encounter.darkness.lights + 1
        local light = {x = x, y = y, radius = r, alpha = fade and 0 or 1}
        table.insert(Game.battle.encounter.darkness.lights, self.light_indexes[type], light)
        if fade then
            Game.battle.timer:tween(fade, light, {alpha = 1})
        end
    end
    local function getLight(type)
        return Game.battle and Game.battle.encounter.darkness.lights[self.light_indexes[type]]
    end
    local function removeLight(type, fade)
        local i = self.light_indexes[type]
        if not i then return end
        if fade then
            Game.battle.timer:tween(fade, Game.battle.encounter.darkness.lights[i], {alpha = 0}, "linear", function()
                table.remove(Game.battle.encounter.darkness.lights, i)
                self.light_indexes[type] = nil
                for k,v in pairs(self.light_indexes) do
                    if v > i then
                        self.light_indexes[k] = v-1
                    end
                end
            end)
        else
            table.remove(Game.battle.encounter.darkness.lights, i)
            self.light_indexes[type] = nil
            for k,v in pairs(self.light_indexes) do
                if v > i then
                    self.light_indexes[k] = v-1
                end
            end
        end
    end
    Utils.hook(Battle, "update", function(orig, battle, dt)
        orig(battle, dt)
        if battle.encounter.darkness then
            local player = battle:getPartyByID("knight")
            if player then
                if not self.light_indexes.player then
                    addLight("player", player.x, player.y - 40, 64)
                else
                    local light = getLight("player")
                    if light then
                        light.x = player.x
                        light.y = player.y - 40
                    end
                end
            end
            if self.light_indexes.ui then
                local light = getLight("ui")
                light.y = battle.battle_ui.y
            end
        end
    end)
    Utils.hook(Battle, "onStateChange", function(orig, battle, old, new)
        orig(battle, old, new)
        if battle.encounter.darkness then
            if old == "DEFENDING" then
                addLight("ui", 320, battle.battle_ui.y, 100, 0.5)
            elseif new == "DIALOGUEEND" then
                removeLight("ui", 0.5)
            end
        end
    end)
    Utils.hook(Soul, "init", function(orig, soul, x, y)
        orig(soul, x, y)
        if Game.battle.encounter.darkness then
            addLight("soul", x, y, 48)
        end
    end)
    Utils.hook(Soul, "update", function(orig, soul, dt)
        orig(soul, dt)
        if Game.battle.encounter.darkness then
            local light = getLight("soul")
            if light then
                light.x = soul.x
                light.y = soul.y
            end
        end
    end)
    Utils.hook(Soul, "remove", function(orig, soul)
        orig(soul)
        if Game.battle.encounter.darkness then
            removeLight("soul")
        end
    end)

    -- small ui override to allow custom y position
    Utils.hook(BattleUI, "update", function(orig, ui, dt)
        orig(ui, dt)
        if ui.override_y then
            ui.y = ui.override_y
        end
    end)

    -- lifeblood code (extra health)
    Utils.hook(OverworldActionBox, "draw", function(orig, box)
        orig(box)
        local lifeblood = (box.chara.lifeblood / box.chara:getStat("health")) * 76
        if lifeblood > 0 then
            -- bar extending
            love.graphics.setColor(0, 0.6, 1)
            love.graphics.rectangle("fill", 204, 24, lifeblood, 9)

            -- number override
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", 144, 11, 16, 12)

            local total_health = box.chara.health + box.chara.lifeblood
            local health_offset = (#tostring(total_health) - 1) * 8
            love.graphics.setColor(0, 0.6, 1)
            love.graphics.setFont(box.font)
            love.graphics.print(total_health, 152 - health_offset, 11)
        end
    end)
    Utils.hook(ActionBoxDisplay, "draw", function(orig, box)
        orig(box)
        local knight = box.actbox.battler.chara
        local lifeblood = (knight.lifeblood / knight:getStat("health")) * 76
        if lifeblood > 0 then
            -- bar extending
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", 204, 20 - box.actbox.data_offset, lifeblood + 2, 13)
            love.graphics.setColor(0, 0.6, 1)
            love.graphics.rectangle("fill", 204, 22 - box.actbox.data_offset, lifeblood, 9)

            -- number override
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("fill", 144, 9 - box.actbox.data_offset, 16, 12)

            local total_health = knight.health + knight.lifeblood
            local health_offset = (#tostring(total_health) - 1) * 8
            love.graphics.setColor(0, 0.6, 1)
            love.graphics.setFont(box.font)
            love.graphics.print(total_health, 152 - health_offset, 9 - box.actbox.data_offset)
        end
    end)
    Utils.hook(PartyBattler, "removeHealth", function(orig, battler, amount)
        local lifeblood = battler.chara.lifeblood
        if lifeblood > 0 then
            if lifeblood > amount then
                battler.lifeblood_lost = true
                battler.chara.lifeblood = lifeblood - amount
            else
                battler.lifeblood_lost = false
                amount = amount - lifeblood
                battler.chara.lifeblood = 0
                orig(battler, amount)
            end
        else
            battler.lifeblood_lost = false
            orig(battler, amount)
        end
    end)
    Utils.hook(Battler, "statusMessage", function(orig, battler, x, y, type, arg, color, kill)
        if battler.lifeblood_lost then
            return orig(battler, x, y, type, arg, {0, 0.6, 1}, kill)
        else
            return orig(battler, x, y, type, arg, color, kill)
        end
    end)
    Utils.hook(Bullet, "onDamage", function(orig, bullet, soul)
        local knight = Game.battle:getPartyByID("knight")
        if knight.chara.lifeblood > 0 then
            local direction
            if bullet.physics then
                if bullet.physics.speed then
                    if bullet.physics.direction then
                        direction = bullet.physics.direction
                    elseif bullet.physics.match_rotation then
                        direction = bullet.rotation
                    end
                elseif bullet.physics.speed_x or bullet.physics.speed_y then
                    direction = math.atan2(bullet.physics.speed_y or 0, bullet.physics.speed_x or 0)
                end
            end
            if not direction then
                direction = Utils.angle(bullet, soul)
            end
            Game.battle:addChild(ParticleEmitter(soul.x, soul.y, {
                layer = "above_soul",
                color = {0, 0.6, 1},
                width = {6,12},
                height = {2,5},
                rotation = direction,
                rotation_var = math.rad(15),
                angle = function(p) return p.rotation end,
                speed = {6,8},
                gravity = 0.4,
                match_rotation = true,
                shrink = 0.1,
                shrink_after = {0.3,0.8},
                amount = {3,4},
            }))
        end
        orig(bullet, soul)
    end)

    -- custom game over
    Utils.hook(Game, "gameOver", function(orig, game, x, y)
        self.died = true
        game.gameover_screenshot = love.graphics.newImage(SCREEN_CANVAS:newImageData())
        if game.battle.encounter.pantheon_music then
            game.battle.encounter:stopMusic()
        end
        if game.battle.encounter.onDeath then
            game.battle.encounter:onDeath()
        end
        if game.battle.encounter.darkness then
            self.light_indexes = {}
            game.battle.encounter.darkness:remove()
            game.battle.encounter.darkness = nil
        end
        game.state = "PANTHEON_GAMEOVER"
        if game:getFlag("in_pantheon", false) then
            game.battle:remove()
            game.world:remove()
            game.stage.timer:script(function(wait)
                game.soul = Sprite("player/nail_soul", x, y)
                game.soul:setOrigin(0.5, 0.5)
                game.stage:addChild(game.soul)
                wait(1)
                game.battle = nil
                game.world = nil
                game.gameover_screenshot = nil
                wait(1.5)
                Assets.playSound("player/dream_enter")
                game.stage.timer:during(5, function(dt)
                    if game.soul then
                        game.soul.x = x + love.math.random(-2,2)
                    end
                end)
                wait(1)
                local ps = ParticleEmitter(x, y, {
                    layer = 100,
                    path = "battle/misc/dream",
                    shape = {"small_a", "small_b"},
                    color = {1,0.95,0.7},
                    alpha = {0.5,0.7},
                    blend = "add",
                    speed = {8,24},
                    friction = {0.2,0.3},
                    spin = {-0.05, 0.05},
                    shrink = 0.1,
                    shrink_after = {1,1.5},
                    amount = 10,
                    every = 0.05,
                })
                game.stage:addChild(ps)
                local fade = ScreenFade({1,1,1}, 0, 1, 2)
                game.stage:addChild(fade)
                wait(2)
                game.soul:remove()
                game.soul = nil
                ps:clear()
                ps:remove()
                wait(1)
                game.world = World()
                game.stage:addChild(game.world)
                game.state = "OVERWORLD"
                game.lock_input = false
                local num = game:getFlag("pantheon_num", 1)
                local room = num == 5 and "peak" or "hub"
                game.world:transitionImmediate(room, "p"..num.."_exit")
                local knight = game:getPartyMember("knight")
                knight.health = knight.stats.health
                game.exiting_encounter = nil
                fade:fadeOutAndRemove(0.05)
            end)
        else
            game.stage.timer:script(function(wait)
                game.soul = Sprite("player/nail_soul", x, y)
                game.soul:setOrigin(0.5, 0.5)
                game.stage:addChild(game.soul)
                wait(1)
                local world, battle = game.world, game.battle
                world.active = false
                world.visible = false
                battle.active = false
                battle.visible = false
                game.world = nil
                game.battle = nil
                game.gameover_screenshot = nil
                wait(1.5)
                game.stage.timer:during(5, function(dt)
                    if game.soul then
                        game.soul.x = x + love.math.random(-2,2)
                    end
                end)
                Assets.playSound("player/dream_enter")
                wait(1)
                local ps = ParticleEmitter(x, y, {
                    layer = 100,
                    path = "battle/misc/dream",
                    shape = {"small_a", "small_b"},
                    color = {1,0.95,0.7},
                    alpha = {0.5,0.7},
                    blend = "add",
                    speed = {8,24},
                    friction = {0.2,0.3},
                    spin = {-0.05, 0.05},
                    shrink = 0.1,
                    shrink_after = {1,1.5},
                    amount = 10,
                    every = 0.05,
                })
                game.stage:addChild(ps)
                local fade = ScreenFade({1,1,1}, 0, 1, 1.5)
                game.stage:addChild(fade)
                wait(1.5)
                game.soul:remove()
                game.soul = nil
                ps:clear()
                ps:remove()
                wait(1)
                game.world = world
                game.battle = battle
                game.world.active = true
                game.world.visible = true
                game.battle.active = true
                game.battle.visible = true
                Game.battle:returnToWorld()
                local knight = Game:getPartyMember("knight")
                knight.health = knight.stats.health
                fade:fadeOutAndRemove()
            end)
        end
    end)
    Utils.hook(Game, "draw", function(orig, game)
        orig(game)
        if game.state == "PANTHEON_GAMEOVER" then
            if game.gameover_screenshot then
                love.graphics.setColor(1,1,1)
                love.graphics.draw(game.gameover_screenshot)
            end
        end
    end)
end

function Mod:onKeyPressed(key)
    if Kristal.Config["debug"] and Game.battle and Input.down("lctrl") and key == "]" then
        Game.battle.encounter:dreamEnd(true)
    end
end

function Mod:save(data)
    local defaults = {
        "pantheon_num",
        "pantheon_series",
        "pantheon_start_time",
        "in_pantheon",
        "bindings",
        "current_tp",
        "hitless",
    }
    for _,k in ipairs(defaults) do
        data.flags[k] = nil
    end
end

function Mod:getActionButtons(battler, buttons)
    return {"fight", "magic", "defend"}
end

function Mod:preUpdate(dt)
    if Game.state == "PANTHEON_GAMEOVER" then
        Game.playtime = Game.playtime + dt
        Game.stage:update(dt)
        return true
    end
end

function Mod:getDeadEnemyByID(id)
    if Game.battle and Game.battle.dead_enemies then
        for _,enemy in ipairs(Game.battle.dead_enemies) do
            if enemy.id == id then
                return enemy
            end
        end
    end
end

function Mod:pantheonTransition(fade)
    local tp, music, music_source
    if Game.battle then
        if Game.battle.encounter.darkness then
            self.light_indexes = {}
            Game.battle.encounter.darkness:remove()
            Game.battle.encounter.darkness = nil
        end
        tp = Game.battle.tension
        music = Game.battle.encounter.pantheon_music
        music_source = Game.battle.encounter.pantheon_music_source
        Game:setFlag("current_tp", tp)
        Game.battle:returnToWorld()
    else
        tp = Game:getFlag("current_tp", 0)
    end
    local series = Game:getFlag("pantheon_series", {})
    if #series > 0 then
        local next = table.remove(series, 1)
        if Utils.startsWith(next, "ROOM_") then
            Mod:stopPantheonMusic(music_source)
            Game.world:loadMap(string.sub(next, 6))
            Game.world:spawnParty("spawn")
            if fade then
                fade:fadeOutAndRemove(0.02)
            else
                Game.world:addChild(ScreenFade({1,1,1}, 1, 0, 0.6))
            end
        else
            local encounter = Registry.createEncounter(next)
            encounter.difficulty = (Game:getFlag("pantheon_num", 1) == 5) and 2 or 1
            local next_music = encounter.pantheon_music
            local to_stop
            if music then
                if Utils.equal(music, next_music) then
                    encounter.pantheon_music_source = music_source
                else
                    if type(music) == "table" then
                        if type(next_music) == "table" then
                            local to_keep = {}
                            for i,v in ipairs(music) do
                                if Utils.containsValue(next_music, v) then
                                    table.insert(to_keep, i)
                                else
                                    to_stop = to_stop or {fade = true}
                                    table.insert(to_stop, music_source[i])
                                end
                            end
                            if #to_keep > 0 then
                                encounter.pantheon_music_source = {}
                                for _,v in ipairs(to_keep) do
                                    table.insert(encounter.pantheon_music_source, music_source[v])
                                end
                            else
                                Assets.playSound("music_transition", 0.8)
                            end
                        else
                            if Utils.containsValue(music, next_music) then
                                encounter.pantheon_music_source = music_source
                                to_stop = {fade = true}
                                for i,v in ipairs(music) do
                                    if v ~= next_music then
                                        table.insert(to_stop, music_source[i])
                                    end
                                end
                            else
                                to_stop = music_source
                                Assets.playSound("music_transition", 0.8)
                            end
                        end
                    elseif type(next_music) == "table" and Utils.containsValue(next_music, music) then
                        encounter.pantheon_music_source = {music_source}
                        to_stop = {fade = true}
                        for i,v in ipairs(next_music) do
                            if v ~= music then
                                table.insert(to_stop, music_source[i])
                            end
                        end
                    else
                        to_stop = music_source
                        Assets.playSound("music_transition", 0.8)
                    end
                end
            end
            Game:encounter(encounter, encounter.start_state or "ACTIONSELECT")
            encounter:onBattleStart()
            if encounter.darkness then
                Mod:initUIDarkness(encounter)
            end
            Game.battle.timer:after(0.35, function()
                Mod:stopPantheonMusic(to_stop)
                Mod:startPantheonMusic(encounter)
            end)
            Game.battle.tension = tp
            if fade then
                fade:fadeOutAndRemove(0.02)
            else
                Game.battle:addChild(ScreenFade({1,1,1}, 1, 0, 0.6))
            end
        end
        Game:setFlag("pantheon_series", series)
    else
        -- u win!!
        local pantheon_num = Game:getFlag("pantheon_num", 1)

        Game.stage.timer:tween(1, fade.color, {0,0,0}, "linear", function()
            fade:setParent(Game.world)
            if pantheon_num == 5 then
                Game.world:startCutscene("credits")
            else
                Game.world:startCutscene("pantheon_end")
            end
        end)
    end
end

function Mod:startPantheonMusic(encounter)
    if not encounter.pantheon_music_source then
        if type(encounter.pantheon_music) == "table" then
            encounter.pantheon_music_source = encounter.pantheon_music_source or {}
            for _,music in ipairs(encounter.pantheon_music) do
                local source = Music()
                source:play(music)
                table.insert(encounter.pantheon_music_source, source)
            end
        else
            encounter.pantheon_music_source = Music()
            encounter.pantheon_music_source:play(encounter.pantheon_music)
        end
    elseif type(encounter.pantheon_music) == "table" then
        local already_playing = {}
        for _,source in ipairs(encounter.pantheon_music_source) do
            already_playing[source.current] = true
        end
        for _,music in ipairs(encounter.pantheon_music) do
            if not already_playing[music] then
                local source = Music()
                source:play(music)
                source.source:seek(encounter.pantheon_music_source[1].source:tell())
                table.insert(encounter.pantheon_music_source, source)
            end
        end
    end
end

function Mod:stopPantheonMusic(music)
    if music then
        if music[1] then
            for _,source in ipairs(music) do
                if music.fade then
                    source:fade(0, 0.5, function()
                        source:stop()
                    end)
                else
                    source:stop()
                end
            end
        else
            music:stop()
        end
    end
end

function Mod:initUIDarkness(encounter)
    self.light_indexes.ui = #encounter.darkness.lights + 1
    local light = {x = 320, y = Game.battle.battle_ui.y, radius = 100, alpha = 0}
    table.insert(encounter.darkness.lights, self.light_indexes.ui, light)
    Game.battle.timer:tween(0.5, light, {alpha = 1})
end

function Mod:openArenaCorner(arena, dist, time, corner)
    if not corner then
        corner = {side = love.math.random(4), half = Utils.randomSign()}
    else
        if not corner.side then
            corner.side = love.math.random(4)
        end
        if not corner.half then
            corner.half = Utils.randomSign()
        end
    end
    local width, height = arena.width, arena.height
    arena.corner_data = {
        corner = corner,
        dist = dist,
        orig_width = width,
        orig_height = height,
    }
    if corner.side == 1 then
        arena:shiftOrigin(0.5, 1)
    elseif corner.side == 2 then
        arena:shiftOrigin(0, 0.5)
    elseif corner.side == 3 then
        arena:shiftOrigin(0.5, 0)
    elseif corner.side == 4 then
        arena:shiftOrigin(1, 0.5)
    end
    local orig_sides = {{0,0}, {width, 0}, {width,height}, {0,height}}
    local sides = {}
    local side_dir = -math.pi/2
    local point_num = #sides
    for i=1,4 do
        local dx, dy = Utils.round(math.cos(side_dir)), Utils.round(math.sin(side_dir))
        table.insert(sides, Utils.copy(orig_sides[i]))
        if i == corner.side then
            if corner.half == -1 then
                table.insert(sides, Utils.copy(orig_sides[i]))
                local side = Utils.copy(orig_sides[i])
                side[1] = side[1] + dx
                side[2] = side[2] + dy
                table.insert(sides, side)
                point_num = #sides
                side = Utils.copy(orig_sides[i])
                local nx, ny = side[1] + dist*dx, side[2] + dist*dy
                Game.battle.timer:tween(time, sides[point_num], {nx, ny})

                table.insert(sides, Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5))
                point_num = #sides
                side = Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5)
                nx, ny = side[1] + dist*dx, side[2] + dist*dy
                Game.battle.timer:tween(time, sides[point_num], {nx, ny})

                table.insert(sides, Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5))
            else
                table.insert(sides, Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5))

                table.insert(sides, Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5))
                point_num = #sides
                local side = Utils.lerp(orig_sides[i], orig_sides[i%4+1], 0.5)
                local nx, ny = side[1] + dist*dx, side[2] + dist*dy
                Game.battle.timer:tween(time, sides[point_num], {nx, ny})

                table.insert(sides, Utils.copy(orig_sides[i%4+1]))
                point_num = #sides
                side = Utils.copy(orig_sides[i%4+1])
                nx, ny = side[1] + dist*dx, side[2] + dist*dy
                Game.battle.timer:tween(time, sides[point_num], {nx, ny})
            end
        end
        side_dir = side_dir + math.pi/2
    end
    Game.battle.timer:during(time + 0.01, function(dt)
        local r_sides = {}
        for i,p in ipairs(sides) do
            local px, py = Utils.round(p[1]), Utils.round(p[2])
            if i > 1 then
                local lp = sides[i-1]
                local lpx, lpy = Utils.round(lp[1]), Utils.round(lp[2])
                if (px ~= lpx) or (py ~= lpy) then
                    table.insert(r_sides, {px, py})
                end
            else
                table.insert(r_sides, {px, py})
            end
        end
        arena:setShape(r_sides)
    end)
    return corner
end

function Mod:revertArenaCorner(arena, time)
    if not arena.corner_data then return end
    local corner = arena.corner_data.corner
    local dist = arena.corner_data.dist
    local width, height = arena.corner_data.orig_width, arena.corner_data.orig_height
    local sides = Utils.copy(arena.shape)
    local side_dir = -math.pi/2
    for _i=1,4 do
        local dx, dy = Utils.round(math.cos(side_dir)), Utils.round(math.sin(side_dir))
        if _i == corner.side then
            local i = _i
            if corner.half == -1 then
                i = i-1
            end
            local p1 = sides[i+2]
            local x, y = p1[1] - dist*dx, p1[2] - dist*dy
            Game.battle.timer:tween(time, sides[i+2], {x, y})
            local p2 = sides[i+3]
            local x2, y2 = p2[1] - dist*dx, p2[2] - dist*dy
            Game.battle.timer:tween(time, sides[i+3], {x2, y2})
            Game.battle.timer:during(time, function(dt)
                local r_sides = {}
                for j,p in ipairs(sides) do
                    local px, py = Utils.round(p[1]), Utils.round(p[2])
                    if j > 1 then
                        local lp = sides[j-1]
                        local lpx, lpy = Utils.round(lp[1]), Utils.round(lp[2])
                        if (px ~= lpx) or (py ~= lpy) then
                            table.insert(r_sides, {px, py})
                        end
                    else
                        table.insert(r_sides, {px, py})
                    end
                end
                arena:setShape(r_sides)
            end, function()
                arena:setSize(width, height)
                arena.corner_data = nil
            end)
            break
        end
        side_dir = side_dir + math.pi/2
    end
end

function Mod:getPointOnEdge(arena)
    local dir = Utils.random(0,math.pi*2, math.pi/2)
    local dx, dy = Utils.round(math.cos(dir+math.pi)), Utils.round(math.sin(dir+math.pi))
    local x, y = love.math.random(arena.left, arena.right), love.math.random(arena.top, arena.bottom)
    if dx ~= 0 then
        x = arena.x + arena.width/2*dx
    else
        y = arena.y + arena.height/2*dy
    end
    return x, y, dir
end

function Mod:getBottomAt(arena, x)
    local y = 0
    for _,side in ipairs(arena.collider.colliders) do
        local sx1, sx2 = side.x + arena:getLeft(), side.x2 + arena:getLeft()
        if (sx1 < x) ~= (sx2 < x) then
            local t = (x - sx1) / (sx2 - sx1)
            local sy1, sy2 = side.y + arena:getTop(), side.y2 + arena:getTop()
            local ny = Utils.lerp(sy1, sy2, t)
            if ny > y then y = ny end
        end
    end
    return y
end

function Mod:getBindingCount()
    local bindings = {"nail", "hp", "tp", "magic"}
    local binding_clears = Game:getFlag("pantheon_bindings", {})
    local complete = 0
    for i=1,5 do
        local pantheon_clear = binding_clears[tostring(i)] or {}
        for _,bind in ipairs(bindings) do
            if pantheon_clear[bind] then
                complete = complete + 1
            end
        end
    end
    return complete
end

function Mod:getBossClears()
    local highest_clear = "none"
    local difficulties = {
        "attuned",
        "ascended",
        "radiant"
    }
    local difficulty_rank = {
        attuned = 1,
        ascended = 2,
        radiant = 3,
    }
    local clears = Game:getFlag("hall_clear", {})
    for i,difficulty in ipairs(difficulties) do
        for _,encounter in ipairs(self.encounters) do
            if ((difficulty_rank[clears[encounter]]) or 0) < i then
                return highest_clear
            end
        end
        highest_clear = difficulty
    end
    return highest_clear
end