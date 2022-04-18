return {
    lifeblood = function(cutscene)
        if Game:getFlag("lifeblood_door_open", false) then
            cutscene:endCutscene()
            return
        end
        local door = Game.stage:getObjects(Registry.getEvent("lifeblooddoor"))[1]
        local bindings = Mod:getBindingCount()
        if bindings < 8 then
            cutscene:endCutscene()
            return
        end
        cutscene:wait(1)
        local mask = ColorMaskFX({0.2,0.6,1}, 0)
        door:addFX(mask)
        Game.world.timer:tween(2, mask, {amount = 1})
        cutscene:wait(2)
        cutscene:shakeCamera(4)
        door:remove()
        Game:setFlag("lifeblood_door_open", true)
    end,
    p4 = function(cutscene)
        if Game:getFlag("p4_unlocked", false) then
            cutscene:endCutscene()
            return
        end
        local gate = Game.stage:getObjects(Registry.getEvent("gate"))[1]
        local clears = Game:getFlag("pantheon_complete", {})
        for i=1,3 do
            if not clears[tostring(i)] then
                cutscene:endCutscene()
                return
            end
        end
        cutscene:wait(1)
        cutscene:wait(gate:disappear())
        cutscene:shakeCamera(4)
        Game:setFlag("p4_unlocked", true)
    end,
    radiance = function(cutscene)
        if Game:getFlag("radiance_unlocked") then
            cutscene:endCutscene()
            return
        end
        local gates = Game.stage:getObjects(Registry.getEvent("gate"))
        local gate
        for _,g in ipairs(gates) do
            if g.gate_id == "radiance" then
                gate = g
                break
            end
        end
        if not Game:getFlag("hall_unlocked", {})["p5/radiance"] then
            cutscene:endCutscene()
            return
        end
        cutscene:wait(1)
        cutscene:wait(gate:disappear())
        cutscene:shakeCamera(4)
        Game:setFlag("radiance_unlocked", true)
    end,
    knight = function(cutscene)
        if Game:getFlag("knight_unlocked") then
            cutscene:endCutscene()
            return
        end
        local gates = Game.stage:getObjects(Registry.getEvent("gate"))
        local gate
        for _,g in ipairs(gates) do
            if g.gate_id == "knight" then
                gate = g
                break
            end
        end
        local highest_clear = Mod:getBossClears()
        if highest_clear == "none" then
            cutscene:endCutscene()
            return
        end
        cutscene:wait(1)
        cutscene:wait(gate:disappear())
        cutscene:shakeCamera(4)
        Game:setFlag("knight_unlocked", true)
    end,
}