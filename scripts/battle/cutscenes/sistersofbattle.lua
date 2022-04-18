return function(cutscene)
    local en = Game.battle.encounter
    en.pantheon_music_source:fade(0, 1)
    Game.battle:resetAttackers()
    en.m2.sprite.shake_x = 8
    en.m2:setAnimation("sit")
    Utils.removeFromTable(Game.battle.enemies, en.m2)
    cutscene:wait(1)
    Game.battle.timer:tween(0.2, en.m1.color, {1,1,1})
    Game.battle.timer:tween(0.2, en.m3.color, {1,1,1})
    cutscene:wait(1.5)
    local enemies = {en.m1, en.m2, en.m3}
    for _,m in ipairs(enemies) do
        m:setAnimation("stand")
        m.health = 500
        m.max_health = 500
    end
    Game.battle.enemies = Utils.copy(enemies)
    en.bosses = Utils.copy(enemies)
    Game.battle.shake = 6
    Assets.playSound("bosses/sisters_of_battle_yell")
    en:playMusic("mantis_lords", 1)
    cutscene:wait(1)
    en.text_override = "The Sisters of Battle team up to\ntest your full might."
    cutscene:endCutscene()
    Game.battle:nextTurn()
end