local WatcherKnight, super = Class("boss")

function WatcherKnight:init(awake)
    super:init(self)
    
    self.name = "Watcher Knight"
    self:setActor("p4/watcherknight")

    self.max_health = 250
    self.health = 250

    self.waves = {
        "p4/watcherknights/wave",
    }

    self.text = {
        "* Lurien watches over the battle.",
        "* A chandelier shines brightly above\nyou.",
    }

    self.asleep = not awake
    if not awake then
        self:setAnimation("asleep")
        self.color = {0.5, 0.5, 0.5}
        self.layer = self.layer - 20
    end
end

function WatcherKnight:wake()
    self.asleep = false
    self:setAnimation("idle")
    local mask = ColorMaskFX({1,0.2,0}, 1)
    self:addFX(mask)
    Game.battle.timer:tween(0.5, mask, {amount = 0}, "linear", function()
        self:removeFX(mask)
    end)
    self:setLayer(self.layer + 20)
    table.insert(Game.battle.enemies, self)
end

return WatcherKnight