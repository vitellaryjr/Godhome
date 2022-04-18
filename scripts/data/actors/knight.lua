local Knight, super = Class(Actor)

function Knight:init()
    super:init(self)

    self.width = 16
    self.height = 38
    self.hitbox = {0,24,16,16}

    self.path = "party/knight"
    self.default = ""
    self.animations = {
        ["battle/transition"] = {"battle/transition", 0.08, false},

        ["battle/idle"] = {"battle/idle", 0.2, true},
        ["battle/hurt"] = {"battle/hurt", 0.1, false, frames = {1,2,"3*3"}},

        ["battle/attack_ready"] = {"battle/attack_ready", 0.2, true},
        ["battle/attack"] = {"battle/attack", 0.05, false},
        ["battle/spell_ready"] = {"battle/spell_ready", 0.15, true},
        ["battle/spell"] = {"battle/spell", 0.08, false, frames={1,1,1}},
        ["battle/spell_end"] = {"battle/spell", 0.08, false, frames={2,3,4,5}, next="battle/idle"},
        ["battle/defend"] = {"battle/defend", 0.2, true},
    }

    self.offsets = {
        ["battle/transition"] = {14,0},
        ["battle/idle"] = {14,0},
        ["battle/hurt"] = {12,0},
        ["battle/attack_ready"] = {12,0},
        ["battle/attack"] = {12,0},
        ["battle/spell"] = {14,0},
    }
end

return Knight