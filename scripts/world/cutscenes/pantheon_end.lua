return function(cutscene)
    local end_time = love.timer.getTime()
    local total_time = end_time - (Game:getFlag("pantheon_start_time", end_time))
    local num = Game:getFlag("pantheon_num", 1)
    cutscene:detachCamera()
    cutscene:panTo(320,240, 0)
    Assets.playSound("pantheon/victory_music")
    cutscene:wait(0.5)
    local gem = PantheonCompleteGem(320, 220)
    Game.world:addChild(gem)
    cutscene:wait(1)
    local bindings = {"nail", "hp", "tp", "magic"}
    local bind_count = 0
    for _,name in ipairs(bindings) do
        if Game:getFlag("bindings", {})[name] then
            bind_count = bind_count + 1
            Assets.playSound("pantheon/binding_chain", 1, 1 + bind_count*0.07)
            gem:activateBinding(name)
            cutscene:wait(0.6)
        end
    end
    cutscene:wait(0.4)
    gem:activateGem()
    local complete = Game:getFlag("pantheon_complete", {})
    complete[tostring(num)] = true
    Game:setFlag("pantheon_complete", complete)
    if Game:getFlag("hitless", false) then
        local hitless = Game:getFlag("pantheon_hitless", {})
        hitless[tostring(num)] = true
        Game:setFlag("pantheon_hitless", hitless)
    end
    local bindings = Game:getFlag("pantheon_bindings", {})
    bindings[tostring(num)] = bindings[tostring(num)] or {}
    for bind,on in pairs(Game:getFlag("bindings", {})) do
        if on then
            bindings[tostring(num)][bind] = true
        end
    end
    Game:setFlag("pantheon_bindings", bindings)
    cutscene:wait(0.5)
    local time_text = Text("TIME", 320, 360)
    local time_text_obj = love.graphics.newText(time_text:getFont(), time_text.text)
    time_text.x = 320 - time_text_obj:getWidth()/2
    time_text.alpha = 0
    time_text.layer = 2100
    Game.world:addChild(time_text)
    Game.world.timer:tween(0.5, time_text, {alpha = 1})
    local total_time_minutes = math.floor(total_time / 60)
    local total_time_seconds = math.floor(total_time % 60)
    local time_number = Text(string.format("%02d:%02d", total_time_minutes, total_time_seconds), 320, 390)
    local time_number_obj = love.graphics.newText(time_number:getFont(), time_number.text)
    time_number.x = 320 - time_number_obj:getWidth()/2
    time_number.alpha = 0
    time_number.layer = 2100
    Game.world:addChild(time_number)
    Game.world.timer:tween(0.5, time_number, {alpha = 1})
    cutscene:wait(0.5)
    cutscene:wait(function() return Input.pressed("confirm") end)
    Game.world.timer:tween(0.5, gem, {alpha = 0}, "linear", function()
        Game.world:removeChild(gem)
    end)
    Game.world.timer:tween(0.5, time_text, {alpha = 0}, "linear", function()
        Game.world:removeChild(time_text)
    end)
    Game.world.timer:tween(0.5, time_number, {alpha = 0}, "linear", function()
        Game.world:removeChild(time_number)
    end)
    cutscene:wait(0.5)
    Game.world:spawnObject(ScreenFade({1,1,1}, 0, 1, 1), 2100)
    cutscene:wait(1)
    cutscene:attachCameraImmediate()
    local marker = "p"..num.."_exit"
    Game.world:transitionImmediate("hub", marker, "down")
    Kristal.saveGame(nil, Game:save("save_spawn"))
    Game.world:spawnObject(ScreenFade({1,1,1}, 1, 0, 1), 2100)
    if num == 4 and not Game:getFlag("p5_unlocked", false) then
        cutscene:wait(1.5)
        local x, y = Game.world.map:getMarker("warp_pos")
        cutscene:wait(cutscene:panTo(x, y, 1))
        local dreamwarp_event = Registry.getEvent("dreamwarp")
        local dreamwarp = dreamwarp_event{
            x = x - 40,
            y = y - 40,
            width = 80,
            height = 80,
            center_x = x,
            center_y = y,
            properties = {
                map = "peak",
                marker = "spawn",
            }
        }
        Game.world:spawnObject(dreamwarp, "objects_warp")
        dreamwarp.sprite.color = {1,1,1}
        Game.world.timer:tween(1, dreamwarp.sprite.color, {1,0.7,0.3})
        Assets.playSound("player/dream_exit")
        Game.world:addChild(ParticleEmitter(dreamwarp.center_x, dreamwarp.center_y, {
            layer = Game.world:parseLayer("objects_ps"),
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.7,1},
            blend = "add",
            spin = {-0.05, 0.05},
            speed = {2,6},
            shrink = 0.01,
            amount = 50,
        }))
        cutscene:wait(1)
        cutscene:wait(cutscene:panTo("p4_exit", 1))
        Game:setFlag("p5_unlocked", true)
    end
end