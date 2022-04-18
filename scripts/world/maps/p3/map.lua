local Sage, super = Class(Map)

function Sage:load()
    super:load(self)
    local series = {
        "p3/hiveknight",
        "p3/elderhu",
        "p3/collector",
        "p3/godtamer",
        "p3/grimm",
        "ROOM_pantheon/bench",
        "p3/galien",
        "p3/greyprince",
        "p3/uumuu",
        "p3/hornet2",
        "p3/sly",
    }
    Game:setFlag("pantheon_series", series)

    Mod:pantheonTransition()
end

return Sage