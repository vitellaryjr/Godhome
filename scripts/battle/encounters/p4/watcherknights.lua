local WatcherKnights, super = Class("bossEncounter")

function WatcherKnights:init()
    super:init(self)

    self.bosses = {
        self:addEnemy("p4/watcherknight", 530, 220, true),
        self:addEnemy("p4/watcherknight", 540, 320, false),
        self:addEnemy("p4/watcherknight", 540, 100, false),
        self:addEnemy("p4/watcherknight", 570, 250, false),
        self:addEnemy("p4/watcherknight", 555, 160, false),
        self:addEnemy("p4/watcherknight", 500, 190, false),
    }

    self.text = "* The Watcher Knights all challenge\nyou!"
    self.pantheon_music = "pantheon_c"

    self.background = false
    self.hide_world = true
    -- how many total enemies have been spawned
    self.total_enemies = 1
end

function WatcherKnights:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.18, 0.05, 0.2}, {0.18, 0.1, 0.18}, {0.01, 0.00, 0.04}))
    Game.battle:addChild(NailmasterNails())

    Game.battle.enemies = {self.bosses[1]}
end

function WatcherKnights:onTurnStart()
    super:onTurnStart(self)
    if #Game.battle.enemies < 2 and Game.battle.turn_count > 1 then
        local new_enemy = self.bosses[2]
        if not new_enemy then return end
        new_enemy.sprite.shake_x = 4
        Game.battle.timer:tween(0.5, new_enemy.color, {1,1,1}, "in-quad", function()
            new_enemy.sprite.shake_x = 0
            new_enemy:wake()
        end)
    end
end

return WatcherKnights