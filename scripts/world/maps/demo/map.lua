local Masters, super = Class(Map)

function Masters:load()
    super:load(self)
    local series = {
        "p1/vengeflyking",
        "p1/dungdefender",
        "p1/mosscharger",
        "p1/hornet",
        "p2/sheo",
    }
    Game:setFlag("pantheon_series", series)
    Game:setFlag("pantheon_num", 1)
    Game:setFlag("in_pantheon", true)

    Mod:pantheonTransition()
end

function Masters:draw()
    super:draw(self)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", 0, 0, Game.world.width, Game.world.height)
end

return Masters