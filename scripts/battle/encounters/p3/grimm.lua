local TroupeMaster, super = Class("bossEncounter")

function TroupeMaster:init()
    super:init(self)

    self.grimm = self:addEnemy("p3/grimm", 540, 220)
    table.insert(self.bosses, self.grimm)

    self.text = "* Grimm takes a bow and challenges\nyou!"
    self.pantheon_music = {"pantheon_d1", "pantheon_d3"}

    self.extra_layer = Music()
    self.extra_layer:play("pantheon_d4", 0)
    self.pantheon_music_source = {self.extra_layer}

    self.background = false
    self.hide_world = true

    self.bowing = true
end

function TroupeMaster:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.08, 0.09}, {0.25, 0.05, 0.05}, {0.03, 0.015, 0.02}))
    Game.battle:addChild(DreamRings({1,0.2,0.2}, 0.1, 6, 6))
    Game.battle:addChild(GrimmLanterns())
    Game.battle.timer:after(0.8, function()
        self.grimm:setAnimation("bow_start")
    end)
end

function TroupeMaster:onDialogueEnd()
    if self.bowing then
        self.bowing = false
        self.grimm:setAnimation("bow_end")
    end
    super:onDialogueEnd(self)
end

return TroupeMaster