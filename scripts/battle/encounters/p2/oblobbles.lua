local Oblobbles, super = Class("bossEncounter")

function Oblobbles:init()
    super:init(self)

    local o1 = self:addEnemy("p2/oblobble", 500, 145)
    local o2 = self:addEnemy("p2/oblobble", 540, 290)
    self.bosses = {o1, o2}

    self.text = "* Oblobbles enter the arena!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Oblobbles:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    Game.battle:addChild(BGChains({{0.25, 0.22, 0.12}, {0.25, 0.18, 0.1, 0.5}}))
end

function Oblobbles:getEncounterText()
    local texts = {
        "* The audience roars with applause.",
        "* Chains stretch to the ceiling.",
        "* The Oblobbles are forced to fight\nyou.",
    }
    if #Game.battle.enemies == 2 then
        Utils.merge(texts, {
            "* The Oblobbles look at each other.",
        })
    else
        Utils.merge(texts, {
            "* The Oblobble is in a frenzy.",
            "* The Oblobble has lost its faith.",
        })
        if self.difficulty == 4 then
            table.insert(texts, "* This bug is [color:yellow]pissing[color:reset] the Oblobble\noff...")
        end
    end
    return Utils.pick(texts)
end

function Oblobbles:getNextWaves()
    return {Utils.pick(Game.battle.enemies):selectWave()}
end

return Oblobbles