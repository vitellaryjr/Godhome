local Radiance, super = Class("boss")

function Radiance:init()
    super:init(self)

    self.name = "Absolute Radiance"
    self:setActor("p5/radiance")

    self.max_health = 3000
    self.health = 3000

    self.waves = {
        "p5/radiance/1/orbs",
        "p5/radiance/1/sword_burst",
        "p5/radiance/1/sword_rows",
        "p5/radiance/1/sword_columns",
        "p5/radiance/1/lasers",
    }
    -- self.waves = {"p5/radiance/4/ascend"}

    self.text = {
        "* Darkness against the Light.",
        "* She will not be forgotten.",
        "* Maybe dreams aren't such great\nthings after all.",
    }

    self.double_damage = true

    self.phase = 1
end

function Radiance:getNextWaves()
    if self.phase == 2 then
        return {"p5/radiance/2/swords"}
    else
        return super:getNextWaves(self)
    end
end

function Radiance:selectWave()
    local wave = super:selectWave(self)
    local has_wall_var = {
        "p5/radiance/1/orbs",
        "p5/radiance/1/sword_columns",
    }
    if Utils.containsValue(has_wall_var, wave) and not Utils.containsValue(self.waves, wave.."_wall") then
        table.insert(self.waves, wave.."_wall")
    end
    return wave
end

function Radiance:hurt(amount, battler, on_defeat)
    local prev_hp = self.health
    super:hurt(self, amount, battler, on_defeat)
    self:checkPhase(prev_hp, self.health)
end

function Radiance:onNailHurt(amount, battler)
    local prev_hp = self.health
    super:onNailHurt(self, amount, battler)
    if self.phase == 2 then
        self:checkPhase(prev_hp, self.health)
        if self.phase == 3 then
            local wave = Game.battle.waves[1]
            wave.finished = true
        end
    elseif self.phase ~= 4 then
        local passed = function(val)
            return prev_hp > val and self.health <= val
        end
        if passed(2000) then
            self.health = 2001
        elseif passed(1800) then
            self.health = 1801
        elseif passed(300) then
            self.health = 301
        end
    end
end

function Radiance:checkPhase(prev_hp, current_hp)
    local passed = function(val)
        return prev_hp > val and current_hp <= val
    end
    local prev_phase = self.phase
    if passed(2000) then
        self.phase = 2
        self.health = Utils.approach(self.health, 2000, 50)
    elseif passed(1800) then
        self.phase = 3
        self.waves = {
            "p5/radiance/3/orbs",
            "p5/radiance/3/sword_burst",
            "p5/radiance/3/sword_rows",
            "p5/radiance/3/lasers",
        }
    elseif passed(300) then
        self.phase = 4
        self.health = Utils.approach(self.health, 300, 50)
        self.waves = {"p5/radiance/4/ascend"}
    end
    if prev_phase ~= self.phase then
        Game.battle.encounter:advancePhase(self.phase)
    end
end

return Radiance