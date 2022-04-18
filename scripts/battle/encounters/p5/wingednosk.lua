local WingedNosk, super = Class("bossEncounter")

function WingedNosk:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p5/wingednosk", 540, 220))

    self.text = "* The Sentinel of Hallownest tests\nyou once more..?"
    self.pantheon_music = "hornet"

    self.background = false
    self.hide_world = true
    self.start_state = "NONE"
end

function WingedNosk:onBattleStart()
    super:onBattleStart(self)

    self.bg = StandardBG({0.33, 0.33, 0.34}, {0.21, 0.21, 0.25}, {0.05, 0.05, 0.06})
    Game.battle:addChild(self.bg)

    self.threads = NoskThreads()
    self.threads.color = {0.7, 0.7, 0.72, 0.7}
    Game.battle:addChild(self.threads)

    self.darkness = LightingOverlay(0)
    self.darkness.lights = {
        {x = 540, y = 180, radius = 100},
    }
    Game.battle:addChild(self.darkness)

    if Game.battle.battle_ui and Game.battle.battle_ui.encounter_text then
        Game.battle.battle_ui.encounter_text:setAdvance(false)
    end
    Game.battle:startCutscene("wingednosktransform", not Game:getFlag("in_pantheon"))
end

return WingedNosk