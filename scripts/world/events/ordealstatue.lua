local Statue, super = Class(Event)

function Statue:init(data)
    super:init(self, data.x, data.y, data.width, data.height)
    self.solid = true
    self.sprite = Sprite("tilesets/statues/ordeal", data.width/2, data.height - 10)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:setScale(2)
    self:addChild(self.sprite)
end

function Statue:onInteract(knight, facing)
    if facing == "up" then
        Game.world:startCutscene(function(cutscene)
            local fade = ScreenFade({1,1,1}, 0, 1, 0.75)
            Game.stage:addChild(fade)
            Assets.playSound("pantheon/transition_short")
            cutscene:wait(1)
            local chara = knight:getPartyMember()
            chara.health = chara.stats.health
            local wait = cutscene:startEncounter("ordeal", false, nil, {wait = false})
            fade:fadeOutAndRemove()
            cutscene:wait(wait)
        end)
    end
end

return Statue