return function(cutscene, skip)
    local en = Game.battle.encounter
    local nosk = Game.battle:getEnemyByID("p5/wingednosk")
    if skip then
        en:stopMusic()
        cutscene:wait(0.35)
        en:playMusic{"pantheon_d1", "pantheon_d2", "pantheon_d3", "pantheon_d4"}
        Game.battle.timer:tween(0.5, en.threads.color, {0.2, 0.2, 0.2})
        Game.battle.timer:tween(0.5, en.bg.color, {0.15, 0.15, 0.15})
        Game.battle.timer:tween(0.5, en.bg.back_color, {0.1, 0.1, 0.12})
        Game.battle.timer:tween(0.5, en.bg.fill, {0, 0, 0})
        Game.battle.timer:tween(0.5, en.darkness, {alpha = 0.2})
        cutscene:shakeCamera(4)
    else
        cutscene:wait(1)
        en.pantheon_music_source:fade(0, 3)
        cutscene:wait(3)
        Game.battle.shake = 4
        Assets.playSound("bosses/nosk_transform_a")
        en:playMusic{"pantheon_d1", "pantheon_d2", "pantheon_d3", "pantheon_d4"}
        nosk:setAnimation("transform_b")
        Game.battle.timer:tween(4, en.threads.color, {0.2, 0.2, 0.2})
        Game.battle.timer:tween(4, en.bg.color, {0.15, 0.15, 0.15})
        Game.battle.timer:tween(4, en.bg.back_color, {0.1, 0.1, 0.12})
        Game.battle.timer:tween(4, en.bg.fill, {0, 0, 0})
        Game.battle.timer:tween(4, en.darkness, {alpha = 0.2})
        cutscene:wait(2)
        Game.battle.shake = 4
        Assets.playSound("bosses/nosk_transform_b")
        nosk:setAnimation("transform_c")
        cutscene:wait(2)
        cutscene:shakeCamera(12)
    end
    nosk.sprite.shake_x = 4
    Assets.playSound("bosses/nosk_transform_c")
    Assets.playSound("bosses/nosk_scream_a", 0.8)
    Game.battle.timer:tween(1, nosk.sprite, {shake_x = 0})
    en.text = "* You've fallen into Nosk's trap."
    if Game.battle.battle_ui then
        Game.battle.battle_ui.current_encounter_text = "* You've fallen into Nosk's trap."
        Game.battle:infoText(en.text)
    end
    nosk:setAnimation("idle")
    nosk.overlay_sprite:setAnimation("idle")
    nosk.float_speed = 0.3
    cutscene.finished_callback = function() end
    cutscene:endCutscene()
    Game.battle:setState("ACTIONSELECT")
end