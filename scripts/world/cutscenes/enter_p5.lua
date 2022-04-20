return function(cutscene, door, knight, dir)
    if dir ~= "up" then return end
    cutscene:walkTo(knight, door.x, door.y + 80, 0.5, "up")
    cutscene:wait(cutscene:panTo(Game.world.width/2, door.y - 100, 0.5))
    local menu = Game.world:spawnObject(PantheonMenu(5), "ui")
    cutscene:wait(function() return not menu.open end)
    if menu.quit then
        -- cutscene:wait(cutscene:panTo(knight, 0.5))
        cutscene:endCutscene()
        return
    end
    local bindings = {}
    for _,binding in ipairs(menu.binding_buttons) do
        bindings[binding.name] = binding.enabled
    end
    Game:setFlag("bindings", bindings)
    Assets.playSound("pantheon/door_enter")
    cutscene:wait(0.5)
    Game.world:spawnObject(ScreenFade({1,1,1}, 0, 1, 2), "above_ui")
    cutscene:wait(2.5)
    Game.world:loadMap("p5")
    Game:setFlag("in_pantheon", true)
    Game:setFlag("pantheon_num", 5)
    Game:setFlag("pantheon_start_time", love.timer.getTime())
end