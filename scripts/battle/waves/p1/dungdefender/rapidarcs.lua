local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(260,140)
end

function Arcs:onStart()
    local arena = Game.battle.arena
    local dirt = self:spawnSprite("battle/p1/dungdefender/dirt", arena.x, arena.bottom)
    dirt.layer = BATTLE_LAYERS["arena"]+1
    dirt:setOrigin(0.5, 1)
    dirt:play(0.1, true)

    local dir = Utils.randomSign()
    local speed = Utils.random(10,12)
    self.timer:script(function(wait)
        self.timer:during(0.5, function()
            dirt.x = dirt.x + speed*dir*DTMULT
            if dirt.x < arena.left+50 then
                dir = 1
            elseif dirt.x > arena.right-50 then
                dir = -1
            end
        end)
        wait(0.5)
        while true do
            self.timer:during(0.5, function()
                dirt.x = dirt.x + speed*dir*DTMULT
                if dirt.x < arena.left+50 then
                    dir = 1
                elseif dirt.x > arena.right-50 then
                    dir = -1
                end
            end)
            wait(1)
            for i=1,4 do
                local sx = Utils.clampMap(i, 1,4, -1,1)*6
                self:spawnBullet("p1/dungdefender/dungarc", dirt.x, dirt.y, sx)
            end
            local def = self:spawnBulletTo(Game.battle.mask, "p1/dungdefender/defarc", dirt.x, dirt.y)
            while def.stage do
                wait()
            end
            dir = Utils.randomSign()
        end
    end)
end

return Arcs