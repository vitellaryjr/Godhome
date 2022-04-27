return {
    ["true"] = function(cutscene)
        local en = Game.battle.encounter
        local radiance = Game.battle:getEnemyByID("p5/radiance")
        Game.battle.timer:tween(0.5, radiance, {x = 440, y = 290}, "out-quad")
        cutscene:wait(2)
        local rad_center = {x = radiance.x + 4, y = radiance.y - radiance.height - 20}
        Assets.playSound("bosses/shadelord/screen_fill", 0.8)
        local void_amb = Music()
        void_amb:play("amb/void")
        Game.battle:addChild(ParticleEmitter(0,400, 640,120, {
            layer = "top",
            shape = "circle",
            color = {0,0,0},
            alpha = {0.5,0.9},
            size = {100,200},
            speed_y = {-3,-12},
            fade = {0.01,0.05},
            fade_after = 2,
            amount = 100,
        }))
        cutscene:wait(0.6)
        local darkness = LightingOverlay(1)
        Game.battle:addChild(darkness)
        en.bg:remove()
        en.clouds_a:remove()
        en.void_grad_b.y = 400
        en.void_grad_b:setLayer(BATTLE_LAYERS["above_battlers"])
        en.void_ps_b.y = 400
        en.void_ps_b:setLayer(BATTLE_LAYERS["above_battlers"])

        local bg_grad = Sprite("enemies/p5/shadelord/gradient", 0,0)
        bg_grad.layer = BATTLE_LAYERS["bottom"]
        Game.battle:addChild(bg_grad)
        local bg_ps = ParticleEmitter(0,480, 640,80, {
            layer = BATTLE_LAYERS["bottom"] + 100,
            shape = "circle",
            color = {0,0,0},
            alpha = {0.2,0.3},
            size = {100,200},
            speed_y = {-4,-6},
            remove_after = 5,
            amount = {4,5},
            every = 0.8,
        })
        Game.battle:addChild(bg_ps)

        Assets.playSound("bosses/shadelord/roar", 0.6)
        local shadelord = ShadeLord()
        Game.battle:addChild(shadelord)

        local intensity = 1
        Game.battle.timer:script(function(wait)
            while true do
                Game.battle.camera.x = SCREEN_WIDTH/2 + love.math.random(-intensity, intensity)
                Game.battle.camera.y = SCREEN_HEIGHT/2 + love.math.random(-intensity, intensity)
                wait(1/30) -- 30fps
            end
        end)

        Game.battle.timer:tween(1.5, darkness, {alpha = 0.1})
        local light = {x = rad_center.x, y = rad_center.y, radius = 60, alpha = 0}
        table.insert(darkness.lights, light)
        Game.battle.timer:tween(0.5, light, {alpha = 1})
        cutscene:wait(4)
        shadelord.a4 = Sprite("enemies/p5/shadelord/arm_b", 319,114)
        shadelord.a4.layer = BATTLE_LAYERS["above_battlers"]
        shadelord.a4:setScale(2)
        shadelord.a4.alpha = 0
        shadelord.a4:setRotationOriginExact(2,26)
        shadelord.a4.rotation = math.rad(-30)
        Game.battle:addChild(shadelord.a4)
        shadelord.a4:fadeTo(1, 0.2)
        cutscene:wait(0.3)
        Assets.playSound("bosses/shadelord/headgrab")
        Game.battle.timer:tween(0.05, shadelord.a4, {rotation = 0}, "linear", function()
            shadelord.a4:setFrame(2)
        end)
        cutscene:wait(1)
        shadelord.a4:setFrame(3)
        radiance:setAnimation("light")
        Assets.playSound("bosses/radiance/eye_open", 0.7)
        Game.battle:addChild(ScreenFade({1,1,1}, 0.6,0, 0.5))
        Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] - 100,
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.5,0.7},
            blend = "add",
            speed = {8,16},
            friction = {0.2,0.3},
            spin = {-0.05, 0.05},
            shrink = 0.1,
            shrink_after = {0.5,1},
            amount = 50,
        }))
        Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] - 100,
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.5,0.7},
            blend = "add",
            scale = 0.8,
            angle = math.rad(-110),
            angle_var = math.rad(20),
            speed = {2,10},
            friction = {0.1,0.2},
            spin = {-0.05, 0.05},
            shrink = 0.1,
            shrink_after = {0.5,1},
            amount = 50,
        }))
        local slashed = false
        for i=1,8 do
            cutscene:wait(function() return Input.pressed("confirm") end)
            slashed = true
            Assets.playSound("bosses/shadelord/slashes")
            local slash = Sprite("enemies/p5/shadelord/slash", rad_center.x, rad_center.y)
            slash.layer = BATTLE_LAYERS["top"] + 100
            slash:setOrigin(0.5, 0.5)
            slash:play(0.05, false)
            Game.battle:addChild(slash)
            Game.battle.timer:every(0.05, function()
                Game.battle:addChild(AfterImage(slash, 0.4))
            end, 8)
            local fade = ScreenFade({0,0,0}, 1)
            fade.layer = fade.layer - 2
            Game.battle:addChild(fade)
            Game.battle:addChild(ScreenFade({1,1,1}, 0.2,0, 0.3))
            cutscene:wait(0.5)
            slash:remove()
            fade:remove()
            Assets.playSound("bosses/radiance/slash_hurt")
            Assets.playSound("bosses/radiance/scream_short", 0.7)
            Game.battle:addChild(ScreenFade({1,0.95,0.7}, 0.2,0, 0.5))
            Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
                layer = BATTLE_LAYERS["top"] - 100,
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.95,0.7},
                alpha = {0.5,0.7},
                blend = "add",
                scale = 0.8,
                angle = math.rad(0),
                angle_var = math.rad(20),
                speed = {2,10},
                friction = {0.1,0.2},
                spin = {-0.05, 0.05},
                shrink = 0.1,
                shrink_after = {0.5,1},
                amount = 50,
            }))
            Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
                layer = BATTLE_LAYERS["top"] - 100,
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.95,0.7},
                alpha = {0.5,0.7},
                blend = "add",
                scale = 0.8,
                angle = math.rad(180),
                angle_var = math.rad(20),
                speed = {2,10},
                friction = {0.1,0.2},
                spin = {-0.05, 0.05},
                shrink = 0.1,
                shrink_after = {0.5,1},
                amount = 50,
            }))
            cutscene:wait(0.1)
        end
        Game.battle:addChild(ScreenFade({1,1,1}, 0.6,0, 0.5))
        radiance:setAnimation("light_final")
        Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] - 100,
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.5,0.7},
            blend = "add",
            speed = {8,18},
            friction = {0.2,0.3},
            spin = {-0.05, 0.05},
            shrink = 0.1,
            shrink_after = {1,1.5},
            amount = 100,
        }))
        local eye_ps = ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] - 100,
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.5,0.7},
            blend = "add",
            scale = {0.5,0.8},
            angle = math.rad(-110),
            angle_var = math.rad(20),
            speed = {10,15},
            spin = {-0.05, 0.05},
            remove_after = 1,
            amount = 10,
            every = 0.05,
        })
        Game.battle:addChild(eye_ps)
        cutscene:wait(2)
        intensity = 3
        eye_ps:remove()
        local explode_ps = ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] + 100,
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
        Game.battle:addChild(explode_ps)
        local dying_amb = Music()
        dying_amb:play("amb/radiance_damage")
        cutscene:wait(3)
        explode_ps:remove()
        dying_amb:stop()
        intensity = 0
        void_amb:stop()
        Assets.playSound("bosses/radiance/final_hit")
        Game.battle.timer:after(0.7, function()
            Assets.playSound("bosses/radiance/scream_long")
        end)
        local fade = ScreenFade({0,0,0}, 1)
        Game.battle:addChild(fade)
        Game.battle:addChild(ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] + 100,
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.5,0.9},
            blend = "add",
            speed = {0,40},
            friction = function(p) return p.physics.speed/(Utils.random(1.5,2.5)*30) end,
            spin = {-0.05, 0.05},
            remove_after = {4,5},
            remove = function(p, remove)
                local init_scale = p.scale_x
                Game.battle.timer:script(function(wait)
                    local time = 0.1
                    Game.battle.timer:tween(time, p, {scale_x = init_scale*0.75, scale_y = init_scale*0.75}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = init_scale, scale_y = init_scale}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = init_scale*0.5, scale_y = init_scale*0.5}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = init_scale*0.75, scale_y = init_scale*0.75}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = 0, scale_y = 0}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = init_scale*0.25, scale_y = init_scale*0.25}, "in-out-quad")
                    wait(time)
                    Game.battle.timer:tween(time, p, {scale_x = 0, scale_y = 0}, "in-out-quad")
                    wait(time)
                    remove()
                end)
            end,
            init = function(p)
                p.drift_angle = Utils.random(math.pi*2)
                p.drift_speed = Utils.random(0.1,0.2)
            end,
            update = function(p)
                p.x = p.x + math.cos(p.drift_angle)*p.drift_speed*DTMULT
                p.y = p.y + math.sin(p.drift_angle)*p.drift_speed*DTMULT
            end,
            amount = 500,
        }))
        cutscene:wait(7)
        local complete = Game:getFlag("pantheon_complete", {})
        complete["5"] = true
        Game:setFlag("pantheon_complete", complete)
        if Game:getFlag("hitless", false) then
            local hitless = Game:getFlag("pantheon_hitless", {})
            hitless["5"] = true
            Game:setFlag("pantheon_hitless", hitless)
        end
        local bindings = Game:getFlag("pantheon_bindings", {})
        bindings["5"] = bindings["5"] or {}
        for bind,on in pairs(Game:getFlag("bindings", {})) do
            if on then
                bindings["5"][bind] = true
            end
        end
        Game:setFlag("pantheon_bindings", bindings)
        Mod:pantheonTransition(fade)
    end,
    ["false"] = function(cutscene)
        local en = Game.battle.encounter
        local radiance = Game.battle:getEnemyByID("p5/radiance")
        Game.battle.timer:tween(0.5, radiance, {x = 440, y = 290}, "out-quad")
        cutscene:wait(2)
        local rad_center = {x = radiance.x + 4, y = radiance.y - radiance.height - 20}
        local intensity = 1
        Game.battle.timer:script(function(wait)
            while true do
                Game.battle.camera.x = SCREEN_WIDTH/2 + love.math.random(-intensity, intensity)
                Game.battle.camera.y = SCREEN_HEIGHT/2 + love.math.random(-intensity, intensity)
                wait(1/30) -- 30fps
            end
        end)

        local explode_ps = ParticleEmitter(rad_center.x, rad_center.y, {
            layer = BATTLE_LAYERS["top"] + 100,
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
        Game.battle:addChild(explode_ps)
        local dying_amb = Music()
        dying_amb:play("amb/radiance_damage")
        cutscene:wait(3)
        explode_ps:remove()
        dying_amb:stop()
        Assets.playSound("bosses/radiance/final_hit")
        local fade = ScreenFade({1,1,1}, 0,1, 0.5)
        fade.layer = fade.layer + 10
        Game.battle:addChild(fade)
        cutscene:wait(2)
        Game.battle:returnToWorld()
        fade:setParent(Game.world)
        fade:fadeOutAndRemove()
    end,
}