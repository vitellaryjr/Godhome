return function(cutscene)
    local en = Game.battle.encounter
    en.pantheon_music_source:fade(0, 0.1)
    cutscene:wait(3)
    cutscene:wait(cutscene:shakeCamera(6))
    en:playMusic("pantheon_c")
    local master = Game.battle:getEnemyByID("p2/soulmaster") or Game.battle:getEnemyByID("p4/soultyrant")
    master:removeFX("fadeout")
    master:removeFX("dream_disappear")
    master.overlay_sprite.alpha = 1
    master:toggleOverlay(false)
    local mask = ColorMaskFX({1,1,1}, 1)
    master:addFX(mask)
    Game.battle.timer:tween(0.5, mask, {amount = 0})
    Game.battle.shake = 6
    Game.battle:addChild(ParticleEmitter(master.x, master.y - master.height, {
        layer = BATTLE_LAYERS["above_battlers"],
        shape = {"circle", "arc"},
        spin_var = 0.5,
        scale = {2,3},
        angles = {0, 2*math.pi},
        physics = {
            speed = 10,
            speed_var = 2,
            friction = 0.25,
        },
        shrink = 0.2,
        shrink_after = 0.5,
        shrink_after_var = 0.1,
        amount = {15,20},
    }))
    cutscene:wait(1)
end