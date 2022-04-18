local GruzMother, super = Class("boss")

function GruzMother:init()
    super:init(self)

    self.name = "Gruz Mother"
    self:setActor("p1/gruzmother")

    self.max_health = 650
    self.health = 650

    self.waves = {
        "p1/gruzmother/charge",
        "p1/gruzmother/slam",
    }

    self.text = {
        "* Gruz Mother snores.",
        "* Buzzing sounds come from her\nbelly.",
        "* Gruz Mother sneezes.",
    }

    self.final_done = false
end

function GruzMother:getNextWaves()
    if self.health <= 0 then
        return {"p1/gruzmother/birth"}
    else
        return super:getNextWaves(self)
    end
end

function GruzMother:onDefeat(damage, battler)
    if Game.battle.encounter.difficulty > 1 and not self.final_done then
        self.hurt_timer = -1
        self:toggleOverlay(true)
        self.overlay_sprite:setAnimation("defeat")
        Game.battle:setWaves{"p1/gruzmother/birth"}
        self.selected_wave = Game.battle.waves[1]
    else
        super:onDefeat(self, damage, battler)
    end
end

return GruzMother