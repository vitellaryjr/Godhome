local Knight, super = Class(Map)

function Knight:load()
    super:load(self)
    local series = {
        "p4/enragedguardian",
        "p4/lostkin",
        "p4/noeyes",
        "p4/traitorlord",
        "p4/whitedefender",
        "ROOM_pantheon/bench",
        "p4/failedchamp",
        "p4/markoth",
        "p4/watcherknights",
        "p4/soultyrant",
        "p4/purevessel",
    }
    Game:setFlag("pantheon_series", series)

    Mod:pantheonTransition()
end

return Knight