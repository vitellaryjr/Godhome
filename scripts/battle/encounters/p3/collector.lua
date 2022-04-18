local Collector, super = Class("bossEncounter")

function Collector:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p3/collector", 540, 220))

    self.text = "* The Collector jumps on top of you!"
    self.pantheon_music = "pantheon_b"

    self.background = false
    self.hide_world = true
end

function Collector:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.18, 0.05, 0.2}, {0.18, 0.1, 0.18}, {0.01, 0.00, 0.04}))
end

function Collector:spawnJarEnemy(type, health)
    local x, y = love.math.random(470,600), love.math.random(60,300)
    while math.abs(x-540) < 30 and math.abs(y-170) < 40 do
        x, y = love.math.random(470,600), love.math.random(60,300)
    end
    local enemy = self:addEnemy("p3/"..type, x, y)
    enemy.health = health
end

return Collector