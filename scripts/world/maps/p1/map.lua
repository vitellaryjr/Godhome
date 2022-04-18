local Masters, super = Class(Map)

function Masters:load()
    super:load(self)
    local series = {
        "p1/vengeflyking",
        "p1/gruzmother",
        "p1/falseknight",
        "p1/mosscharger",
        "p1/hornet",
        "ROOM_pantheon/bench",
        "p1/gorb",
        "p1/dungdefender",
        "p1/soulwarrior",
        "p1/broodingmawlek",
        "p1/nailmasters",
    }
    Game:setFlag("pantheon_series", series)
    Game:setFlag("in_pantheon", true)

    Mod:pantheonTransition()
end

return Masters