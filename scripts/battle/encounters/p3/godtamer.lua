local GodTamer, super = Class("bossEncounter")

function GodTamer:init()
    super:init(self)

    self:addEnemy("p3/godtamer", 520, 140)
    table.insert(self.bosses, self:addEnemy("p3/beast", 540, 280))

    self.text = "* The God Tamer and her beast\nchallenge you!"
    self.pantheon_music = "godtamer"

    self.background = false
    self.hide_world = true

    self.seen_full_waves = {}
end

function GodTamer:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
end

return GodTamer