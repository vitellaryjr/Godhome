local Guardian, super = Class("bossEncounter")

function Guardian:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p5/kristalguardian", 540, 220))

    self.text = "* LET THE GAMES BEGIN!?"
    self.pantheon_music = "jevil"

    self.background = false
    self.hide_world = true
end

function Guardian:onBattleStart()
    super:onBattleStart(self)
    local bg = CrystalBG()
    bg.color = {0.2, 0.15, 0.3}
    bg.back_color = {0.1, 0.1, 0.3, 0.5}
    Game.battle:addChild(bg)
    Game.battle:addChild(JevilBG())
end

return Guardian