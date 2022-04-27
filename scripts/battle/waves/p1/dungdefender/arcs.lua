local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 5
    self:setArenaSize(260,140)
end

function Arcs:onStart()
    local arena = Game.battle.arena
    local dirt = self:spawnSprite("battle/p1/dungdefender/dirt", arena.x, arena.bottom)
    dirt.layer = BATTLE_LAYERS["arena"]+1
    dirt:setOrigin(0.5, 1)
    dirt:play(0.1, true)

    local dir = Utils.randomSign()
    local speed = Utils.random(8,10)
    self.timer:during(Utils.random(1.5,2), function()
        dirt.x = dirt.x + speed*dir*DTMULT
        if dirt.x < arena.left+50 then
            dir = 1
        elseif dirt.x > arena.right-50 then
            dir = -1
        end
    end, function()
        self.timer:after(0.5, function()
            for i=1,4 do
                local sx = Utils.clampMap(i, 1,4, -1,1)*6
                self:spawnBullet("p1/dungdefender/dungarc", dirt.x, dirt.y, sx)
            end
            dirt:play(0.15, false)
        end)
    end)
end

return Arcs