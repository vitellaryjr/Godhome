local Storms, super = Class(Map)

function Storms:onEnter()
    super:onEnter(self)
    self.bg = Game.world:spawnObject(Sprite("tilesets/storm_bg"), "bg")
    self.bg.parallax_x = 0
    self.bg.parallax_y = 0
    Game.world.timer:script(function(wait)
        while true do
            wait(Utils.random(1,3))
            self.bg:play(0.1, false)
        end
    end)
end

return Storms