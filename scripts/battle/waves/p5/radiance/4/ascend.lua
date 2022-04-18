local Ascend, super = Class(Wave)

function Ascend:init()
    super:init(self)
    self.time = -1
    self:setArenaSize(180, 1400)
    self:setArenaOffset(0, -500)
    self:setSoulPosition(320, 300)
end

function Ascend:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    local en = Game.battle.encounter
    local start_y = arena.y
    self.state = 0
    self.radiance = self:spawnBullet("p5/radiance/final_radiance", arena.x, arena.top + 150)
    self.radiance:setSprite("enemies/p5/radiance/angry", 0.15, true)
    self.timer:script(function(wait)
        -- before climbing
        while soul.y > 240 do
            wait()
        end

        -- climbing
        self.state = 1
        local ambience = Music()
        ambience:play("amb/godtuner", 0)
        while arena.y < 700 do
            if soul.y < 240 then
                local offset = soul.y - 240
                soul.y = 240
                arena.y = arena.y - offset
                self.radiance.y = self.radiance.y - offset
                if self.laser then
                    self.laser.y = self.laser.y - offset
                end
                for _,sword in ipairs(self.swords) do
                    sword.y = sword.y - offset
                end
                local lerp = Utils.clampMap(arena.y, start_y,600, 0,1)

                local ui = Game.battle.battle_ui
                if not ui.override_y then
                    ui.override_y = ui.y
                end
                ui.override_y = ui.override_y - offset/3
                local grad = en.void_grad
                grad.y = grad.y - offset/3
                local ps = en.void_ps
                ps.y = ps.y - offset/3
                en.clouds_b.y = en.clouds_b.y - offset/4

                local knight = Game.battle:getPartyByID("knight")
                knight.y = knight.y - offset/2
                local tpbar = Game.battle.tension_bar
                tpbar.y = tpbar.y - offset/2

                local bg = en.bg
                bg.fill = Utils.lerp({0.08, 0.04, 0.03}, {0,0,0}, lerp*0.75)
                bg.color = Utils.lerp({0.3, 0.25, 0.18}, {0,0,0}, lerp*0.75)
                bg.back_color = Utils.lerp({0.3, 0.22, 0.15}, {0,0,0}, lerp*0.75)

                arena.bg_color = Utils.lerp({0,0,0,1}, {0,0,0,0}, lerp*2 - 1)

                en.clouds_a.alpha = Utils.lerp(0.05, 0.02, lerp)
                en.clouds_b.alpha = Utils.lerp(0.1, 0, lerp)
                en.overlay.alpha = Utils.lerp(1, 0, lerp)

                en.pantheon_music_source.volume = Utils.lerp(1, 0, lerp)
                ambience.volume = Utils.lerp(0, 1, lerp)

                if lerp > 0.75 then
                    en.dream_ps:setLayer(BATTLE_LAYERS["arena"] + 10)
                    en.dream_ps.alpha = 0.1
                end
            end
            if soul.y > 480 then
                soul.y = 480
            end
            if arena.y > 0 then
                local size_lerp = Utils.clampMap(arena.y, 0,600, 0,1)
                self:setArenaSize(Utils.lerp(180, 640, size_lerp), 1400)
            end
            wait()
        end

        -- orbs
        self.state = 2
        arena.color = {0,0,0}
        en.void_grad_b = Sprite("enemies/p5/radiance/bg_void_gradient_b", 0, 480)
        en.void_grad_b:setLayer(BATTLE_LAYERS["top"])
        Game.battle:addChild(en.void_grad_b)
        Game.battle.timer:tween(0.5, en.void_grad_b, {y = 320}, "out-quad")
        en.void_ps_b = ParticleEmitter(0, 340, 640, 40, {
            layer = "top",
            shape = "circle",
            color = {0,0,0},
            alpha = {0.7,1},
            size = {8,20},
            speed_y = {-0.5,-1},
            fade = {0.01,0.05},
            fade_after = {1,2},
            shrink = {0.01,0.05},
            shrink_after = {1,2},
            amount = {7,8},
            every = 0.7,
        })
        Game.battle:addChild(en.void_ps_b)
        if self.laser and self.laser.state == "charging" then self.laser:remove() end
        Assets.playSound("bosses/radiance/scream_short_b")
        self.radiance:setSprite("enemies/p5/radiance/idle", 0.15, true)
        while not self.radiance.defeated do
            if soul.y > 360 then
                soul.knockback = 12
                soul.knockback_dir = -math.pi/2
            end
            wait()
        end

        -- defeat
        self.state = 3
        for _,ring in ipairs(en.dream_ps.rings) do
            if not ring.fading then
                ring.timer:remove()
                Game.battle.timer:tween(1, ring, {canvas_alpha = 0}, "linear", function()
                    ring:remove()
                end)
            end
        end
        en.dream_ps:remove()
        ambience:stop()
        arena.color = {0,0,0,0}
        arena.bg_color = {0,0,0,0}
        local enemy_rad = Game.battle:getEnemyByID("p5/radiance")
        enemy_rad.scale_x = 2
        enemy_rad:setPosition(self.radiance.x, self.radiance.y + self.radiance.height)
        enemy_rad:setAnimation("shake")
        enemy_rad.phase = 5
        en.glow.alpha = 0.3
        en.glow.rotation = self.radiance.glow.rotation
        en.glow:setPosition(self.radiance.x, self.radiance.y)
        Game.battle.timer:tween(0.5, en.glow, {alpha = 0})
        wait(0.3)
        local knight = Game.battle:getPartyByID("knight")
        knight.y = 600
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
        if enemy_rad.phase == 5 then
            if Game:getFlag("in_pantheon", false) then
                Game.battle:startCutscene("radiancedefeat.true")
            else
                Game.battle:startCutscene("radiancedefeat.false")
            end
        end
    end)

    -- attacks
    self.timer:script(function(wait)
        wait(1)
        while self.state < 2 do
            if self.state == 2 then break end
            self.laser = self:spawnBullet("p5/radiance/fast_laser", self.radiance.x, self.radiance.y-15, Utils.angle(self.radiance.x, self.radiance.y-15, soul.x, soul.y))
            local timer = 1
            while timer > 0 do
                if self.state == 2 then break end
                timer = timer - DT
                wait()
            end
        end
        self.orbs = {}
        while self.state == 2 do
            self.radiance:teleport(love.math.random(160,480), 150)
            wait(0.5)
            local x, y = love.math.random(50, 640-50), love.math.random(50, 320-50)
            while math.abs(x - soul.x) < 80 and math.abs(y - soul.y) < 80 do
                x, y = love.math.random(50, 640-50), love.math.random(50, 320-50)
            end
            local ps = ParticleAbsorber(x, y, {
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.7,0.3},
                alpha = 0.5,
                blend = "add",
                spin_var = 0.2,
                scale = {0.6,0.8},
                fade_in = 0.3,
                dist = {16,32},
                move_time = 0.5,
                ease = "out-sine",
                amount = {1,2},
                every = 0.1,
            })
            self:spawnObject(ps)
            wait(0.7)
            for _,p in ipairs(ps.particles) do
                p:fadeOutAndRemove(0.005)
            end
            ps:remove()
            local orb = self:spawnBullet("p5/radiance/orb", x, y, Utils.angle(x, y, soul.x, soul.y), 3)
            table.insert(self.orbs, orb)
            self.timer:after(3, function()
                Utils:removeFromTable(self.orbs, orb)
            end)
            wait(1)
        end
    end)
    self.swords = {}
    self.timer:script(function(wait)
        while self.state < 2 do
            wait(1.5)
            if self.state == 2 then break end
            local offset = love.math.random(-10,10)
            local possible_rows = {}
            for i=-10,10 do
                table.insert(possible_rows, i)
            end
            local rows = Utils.pickMultiple(possible_rows, 10)
            for _,row in ipairs(rows) do
                local sword = self:spawnBullet("p5/radiance/sword", 320 + row*30 + offset, -30, math.pi/2)
                table.insert(self.swords, sword)
                sword:launch(4)
                self.timer:after(4, function()
                    Utils.removeFromTable(self.swords, sword)
                end)
            end
        end
    end)
end

return Ascend