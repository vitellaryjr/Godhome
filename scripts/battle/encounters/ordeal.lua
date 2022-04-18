local Ordeal, super = Class(Encounter)

function Ordeal:init()
    super:init(self)
    self.default_xactions = false
    PALETTE["action_strip"] = {0.1, 0.1, 0.15}
    self.music = nil
    self.fake_boss = self:addEnemy("boss", 999, 999)
    self.text = "* you did it\n* the ordeal ended"

    self.spells = {}
end

function Ordeal:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.1, 0.15}, {0.1, 0.1, 0.18}))
    Game.battle.zote_ui = OrdealUI()
    Game.battle:addChild(Game.battle.zote_ui)
    local player = Game.battle:getPartyByID("knight")
    player.y = 272
    
    Game.battle:setState("NONE")
    Game.battle.timer:after(0.5, function()
        Game.battle.tension_bar = TensionBar(-25, 80)
        Game.battle:addChild(Game.battle.tension_bar)
        local actionbox = ActionBox(213, 473, 1, player)
        Game.battle:addChild(actionbox)
        Game.battle.music = Music()
        Game.battle.music:play("eternal_ordeal")
        self:onDialogueEnd()
    end)
end

function Ordeal:createSoul(x, y)
    return NailSoul(x, y)
end

function Ordeal:getNextWaves()
    self.fake_boss.selected_wave = "ordeal"
    return {"ordeal"}
end

return Ordeal