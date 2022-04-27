local BG, super = Class(Object)

function BG:init(fill)
    super:init(self)
    self.layer = BATTLE_LAYERS["bottom"]
    self.fill = fill or {0,0,0}
end

function BG:update()
    super:update(self)
    self.fade = Game.battle.transition_timer / 10
end

function BG:draw()
    super:draw(self)
    local r,g,b = unpack(self.fill)
    love.graphics.setColor(r,g,b, self.fade)
    love.graphics.rectangle("fill", -8, -8, SCREEN_WIDTH+16, SCREEN_HEIGHT+16)
end

return BG