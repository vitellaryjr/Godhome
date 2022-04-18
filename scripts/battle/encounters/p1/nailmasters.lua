local Nailmasters, super = Class("bossEncounter")

function Nailmasters:init()
    super:init(self)

    self.oro = self:addEnemy("p1/oro", 520, 220)
    table.insert(self.bosses, self.oro)

    self.text = "* The Nailmaster challenges you."
    self.pantheon_music = "pantheon_c"

    self.background = false
    self.hide_world = true

    self.phase = 1
    self.cutscene_text = false
end

function Nailmasters:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    Game.battle:addChild(NailmasterNails())
end

function Nailmasters:getEncounterText()
    if self.cutscene_text then
        self.cutscene_text = false
        return "* Oro and Mato reluctantly join\nforces!"
    end
    local texts = {}
    for _,enemy in ipairs(Game.battle.enemies) do
        Utils.merge(texts, enemy.text)
    end
    if #Game.battle.enemies == 2 then
        Utils.merge(texts, {
            "Oro and Mato glare at each other.",
        })
    end
    return Utils.pick(texts)
end

function Nailmasters:getNextWaves()
    local wave = Utils.pick(Game.battle.enemies):selectWave()
    if #Game.battle.enemies == 2 and wave == "p1/nailmasters/naildrop" and love.math.random() < 0.33 then
        wave = Utils.pick(Game.battle.enemies):selectWave()
    end
    return {wave}
end

return Nailmasters