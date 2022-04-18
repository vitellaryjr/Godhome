local SoulWarrior, super = Class("boss")

function SoulWarrior:init()
    super:init(self)

    self.name = "Soul Warrior"
    self:setActor("p1/soulwarrior")

    self.max_health = 450
    self.health = 450

    self.waves = {
        "p1/soulwarrior/orbs",
        "p1/soulwarrior/dives",
    }

    self.text = {
        "* Soul flows through the air.",
        "* Soul warrior forgets why they're\nhere.",
        "* Something whispers behind you.",
    }
end

return SoulWarrior