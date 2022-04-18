local VengeflyKings, super = Class("bossEncounter")

function VengeflyKings:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p1/vengeflyking", 500, 145))
    table.insert(self.bosses, self:addEnemy("p1/vengeflyking", 540, 290))

    self.text = "* Vengefly Kings surround you!"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function VengeflyKings:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
end

function VengeflyKings:getNextWaves()
    local enemies = Game.battle:getActiveEnemies()
    local wave
    if #enemies == 1 then
        wave = Utils.pick{
            "p1/vengeflyking/vengeflies",
            "p1/vengeflyking/charge",
        }
    else
        wave = Utils.pick{
            "p1/vengeflyking/2/vengeflies",
            "p1/vengeflyking/2/charge",
        }
    end
    Utils.pick(enemies).selected_wave = wave
    return {wave}
end

return VengeflyKings