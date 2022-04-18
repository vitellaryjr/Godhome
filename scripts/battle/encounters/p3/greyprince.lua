local GreyPrince, super = Class("bossEncounter")

function GreyPrince:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/greyprince", 540, 220))

    self.text = "* The Terrifying, Beautiful, Powerful,\nGorgeous, Passionate, Diligent,\nOverwhelming, Vigorous, Enchanting,\nMysterious, Sensual, Fearless,\nInvincible Grey Prince Zote\nchallenges you!"
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true
end

function GreyPrince:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.3, 0.23, 0.15}, {0.2, 0.1, 0.2}, {0.05, 0, 0.04}))
    Game.battle:addChild(DreamRings({1,0.7,1}, 0.2, 6, 6))
end

return GreyPrince