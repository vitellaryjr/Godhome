local Dung, super = Class("bossEncounter")

function Dung:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/dungdefender", 540, 220))

    self.text = "* The ground bursts open!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Dung:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.2, 0.15, 0.12}, {0.1, 0.1, 0.18}, {0.0, 0.0, 0.02}))
    Game.battle:addChild(DefenderDrip())
end

function Dung:onDialogueEnd()
    if self.rushing then
        Game.battle.shake = 6
        local defender = Game.battle:getEnemyByID("p1/dungdefender")
        defender:setAnimation("fury")
        Assets.playSound("bosses/dung_defender_roar", 0.8)
        Assets.playSound("bosses/dung_defender_chest_beat", 0.8)
        Game.battle.timer:after(2, function()
            super:onDialogueEnd(self)
        end)
        Game.battle.timer:after(4, function()
            defender:setAnimation("idle")
        end)
    else
        super:onDialogueEnd(self)
    end
end

return Dung