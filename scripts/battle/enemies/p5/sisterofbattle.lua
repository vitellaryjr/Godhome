local MantisLord, super = Class("boss")

function MantisLord:init()
    super:init(self)

    self.name = "Mantis Lord"
    self:setActor("p2/mantislord")

    self.max_health = 400
    self.health = 400

    self.waves = {}
end

function MantisLord:onAdd(parent)
    super:onAdd(self, parent)
    self.chair = Sprite("enemies/p2/mantislords/chair", self.x + 2, self.y + 54) -- magic numbers woohoo
    self.chair:setOrigin(0.5, 1)
    self.chair:setScale(2)
    self.chair.layer = self.layer - 1
    parent:addChild(self.chair)
end

function MantisLord:update()
    super:update(self)
    self.chair.color = self.color
end

function MantisLord:onDefeat(damage, battler)
    local en = Game.battle.encounter
    if en.phase == 1 then
        en.phase = 2
        if Game.battle.battle_ui.encounter_text then
            Game.battle.battle_ui.encounter_text:setAdvance(false)
        end
        Game.battle:startCutscene("sistersofbattle")
    elseif en.phase == 2 then
        self.sprite.shake_x = 8
        self:setAnimation("sit")
        Utils.removeFromTable(Game.battle.enemies, self)
        if #Game.battle.enemies == 0 then
            en.phase = 3
            for _,m in ipairs{en.m1, en.m2, en.m3} do
                Game.battle.timer:tween(0.5, m.color, {1,1,1})
                m:onDefeat(damage, battler)
            end
        else
            Game.battle.timer:tween(0.5, self.color, {0.5,0.5,0.5})
        end
    else
        super:onDefeat(self, damage, battler)
        Game.battle.timer:after(0.7, function()
            local mask = ColorMaskFX({1,1,1}, 0)
            self.chair:addFX(mask)
            Game.battle.timer:tween(0.1, mask, {amount = 1}, "linear", function()
                Game.battle.timer:tween(0.5, self.chair, {alpha = 0}, "linear", function()
                    self.chair:remove()
                end)
            end)
        end)
    end
end

return MantisLord