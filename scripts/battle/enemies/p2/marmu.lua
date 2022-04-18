local Marmu, super = Class("floatyBoss")

function Marmu:init()
    super:init(self)

    self.name = "Marmu"
    self:setActor("p2/marmu")

    self.max_health = 700
    self.health = 700

    self.waves = {}

    self.text = {
        "* Marmu is flying!",
        "* Marmu asks where the Queen is.",
        "* Float like a butterfly.",
    }
end

function Marmu:getNextWaves()
    if self.health / self.max_health > 0.5 then
        return {"p2/marmu/normal"}
    else
        return {"p2/marmu/thorns"}
    end
end

return Marmu