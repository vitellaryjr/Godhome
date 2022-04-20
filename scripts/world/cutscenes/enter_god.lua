return function(cutscene, statue, knight, dir)
    if dir ~= "up" then return end
    local wait = cutscene:walkTo(knight, statue.x + statue.width/2, statue.y + 90, 4, "up")
    cutscene:panTo(statue.x + statue.width/2, statue.y + 50, 0.1)
    cutscene:wait(wait)
    local menu
    if not statue.locked then
        menu = Game.world:spawnObject(StatueMenu(statue), "ui")
    else
        menu = Game.world:spawnObject(LockedStatueMenu(statue), "ui")
    end
    cutscene:wait(function() return not menu.open end)
    if menu.quit then
        cutscene:endCutscene()
        return
    end
    local fade = ScreenFade({1,1,1}, 0, 1, 0.75)
    Game.stage:addChild(fade)
    Assets.playSound("pantheon/transition_short")
    cutscene:wait(1)
    local chara = knight:getPartyMember()
    chara.health = chara.stats.health
    local difficulty = menu.difficulty
    local wait = cutscene:startEncounter(statue:getEncounter(difficulty), false, nil, false)
    local encounter = Game.battle.encounter
    fade:fadeOutAndRemove()
    if difficulty == "attuned" then
        encounter.difficulty = 1
    elseif difficulty == "ascended" then
        encounter.difficulty = 3
    elseif difficulty == "radiant" then
        encounter.difficulty = 4
    end
    cutscene:wait(wait)
    local knight = Game:getPartyMember("knight")
    knight.health = knight.stats.health
    if Mod.died then
        Mod.died = false
        cutscene:endCutscene()
        return
    end
    cutscene:wait(1)
    local difficulties = {
        attuned = 1,
        ascended = 2,
        radiant = 3,
    }
    local clear_tbl = Game:getFlag("hall_clear", {})
    local clear = clear_tbl[statue:getEncounter(difficulty, true)]
    if difficulties[difficulty] > (difficulties[clear] or 0) then
        clear_tbl[statue:getEncounter(difficulty, true)] = difficulty
        Game:setFlag("hall_clear", clear_tbl)

        local gem = statue.alt_active and statue.alt_difficulty_sprite or statue.difficulty_sprite
        local mask = ColorMaskFX({1,1,1}, 0)
        gem:addFX(mask)
        Game.world.timer:tween(0.2, mask, {amount = 1})
        cutscene:wait(0.2)
        cutscene:shakeCamera(1)
        gem:setSprite("tilesets/statues/difficulty_"..difficulty)
        Game.world.timer:tween(0.5, mask, {amount = 0}, "linear", function() gem:removeFX(mask) end)
    end
    Kristal.saveGame(nil, Game:save("spawn"))
end