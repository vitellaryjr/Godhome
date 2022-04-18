local Transition, super = Class(Event)

function Transition:init(data)
    super:init(self, data)
    self.used = false
end

function Transition:onCollide(player)
    if self.used then return end
    self.used = true
    Assets.playSound("pantheon/transition_short")
    Game.stage:addChild(ScreenFade({1,1,1}, 0, 1, 1.2, function(fade)
        Game.stage.timer:after(0.5, function()
            Mod:pantheonTransition(fade)
        end)
    end))
end

return Transition