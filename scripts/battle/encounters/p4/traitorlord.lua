local TraitorLord, super = Class("bossEncounter")

function TraitorLord:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/traitorlord", 540, 220))

    self.text = "* Traitor Lord ambushes you in a\nblind fury!"
    self.pantheon_music = "pantheon_c"

    self.background = false
    self.hide_world = true
end

function TraitorLord:onBattleStart()
    super:onBattleStart(self)
    Game.battle:addChild(StandardBG({0.12, 0.25, 0.14}, {0.12, 0.25, 0.16}, {0, 0.05, 0.04}))
    Game.battle:addChild(MossGrass())
    Game.battle:addChild(TraitorFlowers())
    if love.math.random() < 0.2 then
        Game.battle:addChild(TraitorClub())
    end

    local lord = Game.battle:getEnemyBattler("p4/traitorlord")
    lord:addChild(ParticleEmitter(lord.width/2, lord.height/2, {
        layer = "below_battlers",
        color = {1, 0.6, 0.2},
        alpha = 0.1,
        size = {32,48},
        spin_var = 0.1,
        speed = {1,2},
        fade = 0.03,
        fade_after = 0.7,
        amount = {3,4},
        every = 0.2,
    }))
end

return TraitorLord