local TraitorLord, super = Class("boss")

function TraitorLord:init()
    super:init(self)
    
    self.name = "Traitor Lord"
    self:setActor("p4/traitorlord")

    self.max_health = 550
    self.health = 550

    self.waves = {
        "p4/traitorlord/pound",
        "p4/traitorlord/scythes",
    }

    self.text = {
        "* Traitor Lord is confident he can\nbeat you.",
        "* The Mantis Lords don't miss him.",
        "* Mantis traitors watch in envy.",
    }
end

function TraitorLord:hurt(amount, battler, on_defeat)
    local prev_hp = self.health
    super:hurt(self, amount, battler, on_defeat)
    if (prev_hp > self.max_health*0.75) and (self.health < self.max_health*0.75) then
        self.waves = {
            "p4/traitorlord/pound_thorns",
            "p4/traitorlord/scythes_thorns",
        }
    end
end

return TraitorLord