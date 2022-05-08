local Warp, super = Class(Event)

function Warp:init(data)
    super:init(self, data)
    self:setSprite("tilesets/dream_warp")
    self.sprite.color = {1,0.7,0.3}
    self.collider = CircleCollider(self, data.width/2, data.height/2, data.width/2)

    self.map, self.marker = data.properties.map, data.properties.marker

    self.center_x, self.center_y = data.center_x, data.center_y
end

function Warp:draw()
    local prev_blend = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add", "premultiplied")
    super:draw(self)
    love.graphics.setBlendMode(prev_blend)
end

function Warp:onEnter(knight)
    Game.world:startCutscene(function(cutscene)
        cutscene:walkTo(knight, self.center_x, self.center_y, 0.5, "down")
        cutscene:panTo(self.center_x, self.center_y, 0.5)
        cutscene:wait(1)
        local mask = ColorMaskFX({1,1,1}, 0)
        knight:addFX(mask)
        Game.world.timer:tween(0.75, mask, {amount = 1})
        Assets.playSound("player/dream_enter")
        cutscene:wait(0.75)
        Game.world:addChild(ParticleEmitter(knight.x - knight.width/2, knight.y - knight.height, knight.width, knight.height, {
            layer = Game.world:parseLayer("objects_ps"),
            path = "battle/misc/dream",
            shape = {"small_a", "small_b"},
            color = {1,0.95,0.7},
            alpha = {0.7,1},
            blend = "add",
            angle = -math.pi/2,
            spin = {-0.05, 0.05},
            speed_y = {-2,-10},
            shrink = 0.01,
            amount = 30,
        }))
        knight.visible = false
        cutscene:wait(0.5)
        local fade = ScreenFade({1,1,1}, 0, 1, 1)
        Game.stage:addChild(fade)
        cutscene:wait(1)
        cutscene:wait(cutscene:loadMap(self.map, self.marker))
        cutscene:wait(0.5)
        knight = cutscene:getCharacter("knight")
        knight:addFX(mask)
        knight.visible = false
        fade:fadeOutAndRemove()
        cutscene:wait(1)
        knight.visible = true
        Assets.playSound("player/dream_exit")
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
    end)
end

return Warp