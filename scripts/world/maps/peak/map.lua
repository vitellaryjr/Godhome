local Peak, super = Class(Map)

function Peak:onEnter()
    super:onEnter(self)
    Game.world:spawnObject(DreamFountain(SCREEN_WIDTH/2 * 1.41, Game.world.height/2), "objects_fountain")
    Game.world.music:play("amb/godtuner", 0)
end

function Peak:loadObject(name, data)
    if name == "stormentrance" then
        local complete = Mod:getBindingCount()
        if complete == 20 and not Game:getFlag("landofstorms_done", false) then
            return Game.world:spawnObject(StormEntrance(data.x, data.y), "objects")
        end
    end
    return super:loadObject(self, name, data)
end

function Peak:update(dt)
    super:update(self, dt)
    local knight = Game.world:getPartyCharacter("knight")
    Game.world.music:setVolume(Utils.clampMap(knight.y, 1300,800, 0,1))
end

return Peak