local Orb, super = Class(Event)

function Orb:init(data)
    super:init(self, data)
    self:setSprite("tilesets/dream_warp")
    self.sprite.color = {0.5,1,1}
    self.solid = true

    self.sine = 0
    self.pulse = true
end

function Orb:update()
    super:update(self)
    if self.pulse then
        local prev_value = self.sine
        self.sine = self.sine + DT
        self.sprite.color[1] = 0.5 + 0.2*math.sin(self.sine*2)
        if self.sine % (math.pi*3/4) < prev_value % (math.pi*3/4) then
            Assets.playSound("lifeblood_throb", Utils.random(0.3,0.5))
        end
        self.sine = self.sine % (math.pi)
    end
end

function Orb:draw()
    local prev_blend = love.graphics.getBlendMode()
    love.graphics.setBlendMode("add", "premultiplied")
    super:draw(self)
    love.graphics.setBlendMode(prev_blend)
end

function Orb:onInteract(knight, facing)
    Game.world:startCutscene(function(cutscene)
        self.pulse = false
        Assets.playSound("lifeblood_orb_slashed")
        Game.world.timer:tween(0.5, self.sprite.color, {0.8,1,1})
        cutscene:wait(1)
        local fade = Game.world:spawnObject(ScreenFade({0.5,0.7,1}, 0,0.2, 2), 9999)
        Game.world.timer:tween(2, self.sprite.color, {1,1,1})
        cutscene:wait(2)
        fade:fadeOutAndRemove()
        self:remove()
        Assets.playSound("lifeblood_orb_final_boom")
        Game:setFlag("lifeblood_active", true)
    end)
end

return Orb