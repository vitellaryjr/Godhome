local ShadowCrystal, super = Class("boss")

function ShadowCrystal:init()
    super:init(self)

    self.name = "Kristal Guardian"
    self:setActor("p5/kristalguardian")

    self.max_health = 1000
    self.health = 1000

    self.proj_hb = Hitbox(self, 19,7, 18,38)

    self.waves = {
        "p5/kristalguardian/circlesA",
        "p5/kristalguardian/laserbombs",
        "p5/kristalguardian/shardbombs",
        "p5/kristalguardian/pickaxebombs",
        "p5/kristalguardian/conveyor_staticA",
        "p5/kristalguardian/conveyor_crawlersA",
        "p5/kristalguardian/devilsaxeA",
    }

    self.text = {
        "* The world is spinning, spinning.",
        "* You look through the Kristal\nGuardian. For a moment, you see\nHallownest's Crown.",
        "* Screams sing out from within the\ncrystals.",
        "* The room gets brighter and brighter.",
        "* Mechanical and infectious heartbeats\nsyncopate in the air.",
        "* A chaotic mixture of shadow and\nlight.",
    }
end

function ShadowCrystal:selectWave()
    local wave = super:selectWave(self)
    if string.sub(wave, -1) == "A" then
        Utils.removeFromTable(self.waves, wave)
        local new_wave = string.sub(wave, 1, -2).."B"
        table.insert(self.waves, new_wave)
        self.seen_waves[new_wave] = true
    end
    local bombwaves = {
        "p5/kristalguardian/laserbombs",
        "p5/kristalguardian/shardbombs",
        "p5/kristalguardian/pickaxebombs",
    }
    if Utils.containsValue(bombwaves, wave) then
        local all_seen = true
        for _,w in ipairs(bombwaves) do
            if not self.seen_waves[w] then
                all_seen = false
                break
            end
        end
        if all_seen then
            for _,w in ipairs(bombwaves) do
                Utils.removeFromTable(self.waves, w)
            end
            table.insert(self.waves, "p5/kristalguardian/chaosbomb")
        end
    end
    return wave
end

function ShadowCrystal:onDefeat(...)
    super:onDefeat(self, ...)
    Game.battle.encounter:stopMusic()
end

return ShadowCrystal