local Hallownest, super = Class(Map)

function Hallownest:load()
    super:load(self)
    local series = {
        "p1/vengeflyking_asc",
        "p1/gruzmother",
        "p1/falseknight",
        "p1/mosscharger",
        "p1/hornet",
        "p1/gorb",
        "p1/dungdefender",
        "p1/soulwarrior",
        "p1/broodingmawlek",
        "p1/nailmasters",
        "ROOM_pantheon/bench",
        "p2/xero",
        "p2/crystalguardian",
        "p2/soulmaster",
        "p2/oblobbles",
        "p5/sisters",
        "ROOM_pantheon/bench",
        "p2/marmu",
        "p2/flukemarm",
        "p2/brokenvessel",
        "p3/galien",
        "p2/sheo",
        "ROOM_pantheon/bench",
        "p3/hiveknight",
        "p3/elderhu",
        "p3/collector",
        "p3/godtamer",
        "p3/grimm",
        "ROOM_pantheon/bench",
        "p4/watcherknights",
        "p3/uumuu",
        "p5/wingednosk",
        "p3/sly",
        "p3/hornet2",
        "ROOM_pantheon/bench",
        "p5/kristalguardian",
        "p4/lostkin",
        "p4/noeyes",
        "p4/traitorlord",
        "p4/whitedefender",
        "ROOM_pantheon/bench",
        "p4/soultyrant",
        "p4/markoth",
        "p3/greyprince",
        "p4/failedchamp",
        "p5/nkg",
        "ROOM_pantheon/bench",
        "p4/purevessel",
        "p5/radiance",
    }
    Game:setFlag("pantheon_series", series)

    Mod:pantheonTransition()
end

return Hallownest