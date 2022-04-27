local Nightmare, super = Class("bossEncounter")

function Nightmare:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p5/nkg", 540, 220))

    self.text = "* Burn away the Nightmare King."
    self.pantheon_music = {"pantheon_d1", "pantheon_d2", "pantheon_d3", "pantheon_d4"}

    self.background = false
    self.hide_world = true

    self.phase = 1
    self.beat = 0
    self.beat_timer = 0
end

function Nightmare:onBattleStart()
    super:onBattleStart(self)
    self.bg = StandardBG({0.3, 0.1, 0.12}, {0.25, 0.05, 0.05}, {0.07, 0.015, 0.02})
    self.bg.speed = 1
    Game.battle:addChild(self.bg)
    Game.battle:addChild(DreamRings({1,0.3,0.32}, 0.3, 10, 6))
    self.heart = NightmareHeart()
    Game.battle:addChild(self.heart)
end

function Nightmare:update()
    super:update(self)
    self.beat_timer = self.beat_timer + DT
    if self.beat_timer > 0.5 then
        self.beat = self.beat + 1
        self.beat_timer = self.beat_timer - 0.5
        if (self.phase == 2 or self.phase == 3) and (self.beat % 2 == 0) then
            self.heart:beat()
        elseif self.phase == 4 then
            self.heart:beat()
        end
    end
end

function Nightmare:advancePhase()
    self.phase = self.phase + 1
    if self.phase == 2 then
        Game.battle.timer:tween(1, self.bg, {speed = 1.25})
    elseif self.phase == 3 then
        local glow = Sprite("battle/p5/nkg/bg_heart_glow", 320, 0)
        glow:setOrigin(0.5, 0)
        glow.layer = BATTLE_LAYERS["bottom"] + 15
        glow.alpha = 0
        Game.battle:addChild(glow)
        Game.battle.timer:tween(1, glow, {alpha = 0.4})
    elseif self.phase == 4 then
        Game.battle.timer:tween(1, self.bg, {speed = 1.5})
    end
end

return Nightmare