local Paintmaster, super = Class("bossEncounter")

function Paintmaster:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p2/sheo", 520, 240))

    self.text = "* Sheo takes a break from painting\nto challenge you!"
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true
    self.to_add = nil
end

function Paintmaster:getNextWaves()
    local waves = super:getNextWaves(self)
    local wave = string.sub(waves[1], 9)
    if wave == "greatslash" then
        self.to_add = {1, 0.4, 0.8}
    elseif wave == "stab" then
        self.to_add = {1, 0.95, 0.4}
    elseif wave == "arcs" then
        self.to_add = {0.4, 0.4, 1}
    elseif wave == "movement" then
        self.to_add = Utils.pick{{0.4, 1, 1}, {1, 0.7, 0.4}}
    end
    return waves
end

function Paintmaster:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    self.drip = SheoPaintDrip()
    Game.battle:addChild(self.drip)
end

function Paintmaster:onTurnStart()
    if self.to_add then
        self.drip:addColor(self.to_add)
        self.to_add = nil
    end
end

return Paintmaster