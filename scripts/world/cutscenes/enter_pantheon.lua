return function(cutscene, door, knight, dir)
    if dir ~= "up" then return end
    local wait = cutscene:walkTo(knight, door.x + 40, door.y + 150, 4, "up")
    cutscene:panTo(door.x + 40, door.y + 110, 0.1)
    cutscene:wait(wait)
    local menu = Game.world:spawnObject(PantheonMenu(door.pantheon), "ui")
    cutscene:wait(function() return not menu.open end)
    if menu.quit then
        cutscene:endCutscene()
    end
    local bindings = {}
    for _,binding in ipairs(menu.binding_buttons) do
        bindings[binding.name] = binding.enabled
    end
    Game:setFlag("bindings", bindings)
    cutscene:wait(0.5)
    door.sprite:addFX(MaskFX(door.mask_sprite))
    Assets.playSound("pantheon/door_enter")
    Game.world.timer:tween(0.5, door.sprite, {y = -10}, "out-quad")
    cutscene:wait(0.6)
    Game.world.timer:tween(1, door.sprite, {y = -120}, "in-cubic")
    cutscene:wait(0.75)
    door.solid = false
    cutscene:walkTo(knight, door.x + 40, door.y + 80, 1)
    knight.sprite:addFX(MaskFX(door.mask_sprite))
    local colormask = ColorMaskFX({1,1,1}, 0)
    knight.sprite:addFX(colormask)
    Game.world.timer:tween(1, colormask, {amount = 1})
    cutscene:wait(0.5)
    Game.world:spawnObject(ScreenFade({1,1,1}, 0, 1, 1), "above_ui")
    cutscene:wait(1.25)
    cutscene:endCutscene()
    local chara = knight:getPartyMember()
    chara.health = chara.stats.health
    Game.world:loadMap("p"..door.pantheon)
    Game:setFlag("in_pantheon", true)
    Game:setFlag("pantheon_num", door.pantheon)
    Game:setFlag("pantheon_start_time", love.timer.getTime())
end