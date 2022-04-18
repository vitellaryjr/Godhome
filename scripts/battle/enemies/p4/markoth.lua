local Markoth, super = Class("floatyBoss")

function Markoth:init()
    super:init(self)

    self.name = "Markoth"
    self:setActor("p4/markoth")

    self.max_health = 700
    self.health = 700

    self.text = {
        "* The darkness has come to consume\nhim.",
        "* Dreaming at the edge of the world.",
        "* Markoth's shield clinks against your\nnail.",
    }
end

function Markoth:getNextWaves()
    if self.health / self.max_health > 0.5 then
        return {"p4/markoth/swords_a"}
    else
        return {"p4/markoth/swords_b"}
    end
end

return Markoth