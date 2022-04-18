local MantisLords, super = Class("bossEncounter")

function MantisLords:init()
    super:init(self)

    self.m1 = self:addEnemy("p5/sisterofbattle", 475, 160)
    self.m2 = self:addEnemy("p5/sisterofbattle", 530, 220)
    self.m3 = self:addEnemy("p5/sisterofbattle", 585, 280)

    self.m1.color = {0.5, 0.5, 0.5}
    self.m3.color = {0.5, 0.5, 0.5}

    self.m2:setAnimation("idle")
    self.m2.health = 300
    self.m2.max_health = 300
    self.bosses = {self.m2}

    self.text = "* You challenge the Mantis Lords."
    self.pantheon_music = "mantis_lords_normal"

    self.background = false
    self.hide_world = true

    self.phase = 1
    self.seen_waves = {}
end

function MantisLords:onBattleStart()
    super:onBattleStart(self)
    Game.battle.enemies = {self.m2}
    Game.battle:addChild(StandardBG({0.25, 0.22, 0.12}, {0.25, 0.18, 0.1}, {0.015, 0.013, 0.005}))
    Game.battle:addChild(ParticleEmitter(0,0, SCREEN_WIDTH,SCREEN_HEIGHT, {
        layer = BATTLE_LAYERS["top"],
        color = {1,0.95,0.6},
        alpha = {0.2,0.5},
        size = 4,
        speed = {0,0.5},
        fade_in = 0.05,
        fade = {0.01,0.05},
        fade_after = {1,2},
        amount = {3,5},
        every = 1,
    }))
end

function MantisLords:getEncounterText()
    if self.text_override then
        local text = self.text_override
        self.text_override = nil
        return text
    else
        return Utils.pick{
            "* The Godseeker can't see what's\ngoing on, but assumes it's very\nimpressive.",
            "* The sisters sharpen their lances\nwith their claws.",
            "* Mantis children watch their lords\nwith complete respect."
        }
    end
end

function MantisLords:getNextWaves()
    local enemies = Game.battle:getActiveEnemies()
    local wave
    if #enemies == 1 then
        wave = Utils.pick({
            "p2/mantislords/blades1",
            "p2/mantislords/dash",
        }, function(v) return not self.seen_waves[v] end)
        if not wave then wave = Utils.pick{
            "p2/mantislords/blades1",
            "p2/mantislords/dash",
        } end
    elseif #enemies == 2 then
        wave = Utils.pick({
            "p2/mantislords/blades2",
            "p2/mantislords/dash",
        }, function(v) return not self.seen_waves[v] end)
        if not wave then wave = Utils.pick{
            "p2/mantislords/blades2",
            "p2/mantislords/dash",
        } end
    else
        wave = Utils.pick({
            "p2/mantislords/blades3",
            "p2/mantislords/dash",
        }, function(v) return not self.seen_waves[v] end)
        if not wave then wave = Utils.pick{
            "p2/mantislords/blades3",
            "p2/mantislords/dash",
        } end
    end
    self.seen_waves[wave] = true
    Utils.pick(enemies).selected_wave = wave
    return {wave}
end

return MantisLords