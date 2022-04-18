local Stab, super = Class(Bullet)

function Stab:init(x, y, dir)
    super:init(self, x, y, "battle/p2/sheo/stab_start")
    self.sprite:play(0.1, false, function()
        self:setSprite("battle/p2/sheo/stab", 0.1, true)
    end)
    self:setOrigin(0, 0.5)
    self:setHitbox(0,12.5,65,5)
    self.rotation = dir
end

function Stab:onAdd(parent)
    super:onAdd(self, parent)
    local hx,hy,hw,hh = self:getHitbox()
    local x,y = self:getRelativePos(hx,hy, Game.battle)
    local x2,y2 = self:getRelativePos(hw,hh, Game.battle)
    local w,h = (x2-x), (y2-y)
    if w < 0 then
        x = x+w
        w = -w
    end
    if h < 0 then
        y = y+h
        h = -h
    end
    self.wave.timer:after(0.1, function()
        self:setSprite("battle/p2/sheo/stab_end", 0.1, false, function()
            self:remove()
        end)
        Game.battle:addChild(ParticleEmitter(x, y, w, h, {
            shape = "circle",
            color = {1, 0.95, 0.4},
            size = {8,10},
            angle = math.pi/2,
            speed = {3,5},
            gravity = 0.2,
            shrink = 0.1,
            shrink_after = {0.1,0.2},
            amount = {10,14},
        }))
    end)
end

return Stab