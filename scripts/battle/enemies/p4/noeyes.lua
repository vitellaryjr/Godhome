local NoEyes, super = Class("floatyBoss")

function NoEyes:init()
    super:init(self)

    self.name = "No Eyes"
    self:setActor("p4/noeyes")

    self.max_health = 600
    self.health = 600

    self.waves = {
        "p4/noeyes/wave",
    }

    self.text = {
        "* No Eyes sings you a lullaby.",
        "* No Eyes misses her children.",
        "* It's kinda hard to see. Having eyes\ntends to help with that, though.",
    }
end

return NoEyes