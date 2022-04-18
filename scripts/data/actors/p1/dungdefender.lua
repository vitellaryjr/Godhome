local DungDefender, super = Class(Actor)

function DungDefender:init()
    super:init(self)

    self.width = 50
    self.height = 60

    self.path = "enemies/p1/dungdefender"
    self.default = "idle"
    self.animations = {
        ["idle"] = {"idle", 0.1, true},
        ["fury"] = {"fury", 0.15, true},
    }
end

return DungDefender