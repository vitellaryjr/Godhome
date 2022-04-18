local Lifeblood, super = Class(Map)

function Lifeblood:load()
    super:load(self)
    Game.world:spawnObject(DreamRings({0.5,0.6,1}, 0.2, 16, 6), "objects_ps")
end

return Lifeblood