local Uumuu, super = Class("bossEncounter")

function Uumuu:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/uumuu", 520, 240))

    self.text = "* Monomon's creation defends her!"
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true

    self.vuln_count = 0
end

function Uumuu:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.1, 0.3, 0.12}, {0.3, 0.3, 0.1}, {0, 0.03, 0.005}))
    Game.battle:addChild(UumuuFog())
end

function Uumuu:onDialogueEnd()
    self.vuln_count = self.vuln_count - 1
    if self.vuln_count > 0 then
        Game.battle:nextTurn()
    elseif self.vuln_count == 0 then
        local battler = Game.battle:getEnemyBattler("p3/uumuu")
        battler.hurt_timer = 0.4
        battler.sprite.shake_x = 4
        battler:setAnimation("idle")
        battler.defense = 999
        Game.battle.timer:after(1, function()
            super:onDialogueEnd(self)
        end)
    else
        super:onDialogueEnd(self)
    end
end

return Uumuu