local Oblobble, super = Class("boss")

function Oblobble:init()
    super:init(self)

    self.name = "Oblobble"
    self:setActor("p2/oblobble")

    self.max_health = 350
    self.health = 350

    self.waves = {}

    self.sine = 0
    self.angry = false
end

function Oblobble:update()
    super:update(self)
    if self.angry then
        self.sine = self.sine + DT
        local t = math.abs(math.sin(self.sine*2.5)) * 0.75
        self.color = Utils.lerp({1,1,1}, {1,0.1,0}, t)
    end
end

function Oblobble:getNextWaves()
    if self.angry then
        return {"p2/oblobbles/frenzy"}
    else
        return {"p2/oblobbles/normal"}
    end
end

function Oblobble:onDefeat(damage, battler)
    super:onDefeat(self, damage, battler)
    if #Game.battle.enemies > 0 then
        local other = Game.battle.enemies[1]
        other.health = math.min(other.max_health, other.health + other.max_health/2)
        Game.battle.timer:after(1, function()
            other.angry = true
        end)
    end
end

return Oblobble