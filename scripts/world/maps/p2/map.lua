local Artist, super = Class(Map)

function Artist:load()
    super:load(self)
    local series = {
        "p2/xero",
        "p2/crystalguardian",
        "p2/soulmaster",
        "p2/oblobbles",
        "p2/mantislords",
        "ROOM_pantheon/bench",
        "p2/marmu",
        "p2/nosk",
        "p2/flukemarm",
        "p2/brokenvessel",
        "p2/sheo",
    }
    Game:setFlag("pantheon_series", series)

    Mod:pantheonTransition()
end

return Artist