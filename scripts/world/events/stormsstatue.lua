local Statue, super = Class(Event)

function Statue:init(data)
    super:init(self, data.x, data.y, data.width, data.height)
    self.sprite = Sprite("tilesets/statues/storms_radiance", data.width/2, data.height)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:setScale(2)
    self:addChild(self.sprite)
    self.solid = true

    self.ps = ParticleEmitter(self.x, self.y, self.width, self.sprite.height, {
        layer = self.layer + 1,
        path = "battle/misc/dream",
        shape = {"small_a", "small_b"},
        color = {1,0.95,0.7},
        alpha = {0.1,0.2},
        blend = "add",
        fade_in = 0.05,
        fade = 0.01,
        fade_after = {0.5,1},
        speed_y = {-1,-2},
        spin_var = math.rad(1),
        amount = {2,3},
        every = 1,
    })
    Game.world:addChild(self.ps)
end

function Statue:onInteract(knight, facing)
    Game.world:startCutscene(function(cutscene)
        cutscene:text("* The statue glows softly,\nemanating a dreamlike light.")
        cutscene:text("* Enter the statue?")
        local choice = cutscene:choicer({"Yes", "No"})
        if choice == 2 then
            cutscene:endCutscene()
            return
        end
        cutscene:wait(1)
        local mask = ColorMaskFX({1,1,1}, 0)
        knight:addFX(mask)
        Game.world.timer:tween(0.75, mask, {amount = 1})
        cutscene:wait(0.75)
        Game.world:addChild(ParticleEmitter(knight.x - knight.width/2, knight.y - knight.height, knight.width, knight.height, {
            layer = Game.world:parseLayer("objects_ps"),
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.7,1},
            blend = "add",
            spin = {-0.05, 0.05},
            speed = {0.5,1},
            shrink = 0.01,
            amount = 20,
        }))
        knight.visible = false
        cutscene:wait(1)
        local fade = ScreenFade({1,1,1}, 0, 1, 2)
        Game.stage:addChild(fade)
        cutscene:wait(2)
        cutscene:wait(cutscene:loadMap("hub", "spawn"))
        cutscene:wait(0.5)
        knight = cutscene:getCharacter("knight")
        knight:setFacing("down")
        knight:addFX(mask)
        knight.visible = false
        fade:fadeOutAndRemove(0.02)
        cutscene:wait(2)
        knight.visible = true
        Game.world:addChild(ParticleEmitter(knight.x - knight.width/2, knight.y - knight.height, knight.width, knight.height, {
            layer = Game.world:parseLayer("objects_ps"),
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.7,1},
            blend = "add",
            angle = -math.pi/2,
            spin = {-0.05, 0.05},
            speed_y = {2,10},
            shrink = 0.01,
            amount = 30,
        }))
        Game.world.timer:tween(0.75, mask, {amount = 0}, "linear", function()
            knight:removeFX(mask)
        end)
        Game:setFlag("landofstorms_done", true)
    end)
end

return Statue