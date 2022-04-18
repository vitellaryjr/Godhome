local Guardian, super = Class("boss")

function Guardian:init()
    super:init(self)

    self.name = "Crystal Guardian"
    self:setActor("p2/crystalguardian")

    self.max_health = 400
    self.health = 400

    self.waves = {
        "p2/crystalguardian/static",
        "p2/crystalguardian/crawlers",
    }

    self.text = {
        "* You look through the Crystal\nGuardian.",
        "* The floor is scratched with pickaxe\nmarks.",
        "* A mechanical heartbeat pounds in the\ndistance.",
    }
end

return Guardian