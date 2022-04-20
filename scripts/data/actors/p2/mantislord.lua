-- return {
--     id = "mantislord",
--     width = 24, height = 74,

--     path = "enemies/p2/mantislords",
--     default = "sit",
--     animations = {
--         ["sit"] = {"sit", 0, false},
--         ["stand"] = {"stand", 0.1, false, next="idle"},
--         ["idle"] = {"idle", 0.5, true},
--     },
--     offsets = {
--         ["stand"] = {10,16},
--         ["idle"] = {10,16},
--     }
-- }

local MantisLord, super = Class(Actor)

function MantisLord:init()
    super:init(self)

    self.width = 24
    self.height = 74

    self.path = "enemies/p2/mantislords"
    self.default = "sit"
    self.animations = {
        ["sit"] = {"sit", 0, false},
        ["stand"] = {"stand", 0.1, false, next="idle"},
        ["idle"] = {"idle", 0.5, true},
    }
    self.offsets = {
        ["stand"] = {-10,-16},
        ["idle"] = {-10,-16},
    }
end

return MantisLord