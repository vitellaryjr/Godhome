return function(cutscene)
    local en = Game.battle.encounter
    local oro = en.oro
    en.pantheon_music_source:fade(0, 1)
    oro:setAnimation("down")
    Game.battle.timer:tween(0.8, oro, {x=540, y=300}, "out-sine")
    cutscene:wait(1.5)
    local mato = en:addEnemy("p1/mato", 500, -10)
    en.mato = mato
    table.insert(en.bosses, mato)
    mato:setAnimation("enter")
    Assets.playSound("bosses/nailmaster_enter", 0.8)
    Game.battle.timer:tween(0.2, mato, {y=160})
    for i=1,11 do
        mato:addChild(AfterImage(mato.sprite, 0.5))
        cutscene:wait(0.02)
    end
    Assets.playSound("bosses/nailmaster_land")
    Game.battle.shake = 4
    mato:setAnimation("down")
    cutscene:wait(1.8)
    oro:setAnimation("idle")
    mato:setAnimation("idle")
    oro.max_health = 450
    oro.health = 450
    Game.battle.enemies = {mato, oro}
    en.cutscene_text = true
    cutscene:endCutscene()
    en:playMusic("pantheon_a", 1)
    Game.battle:nextTurn()
end