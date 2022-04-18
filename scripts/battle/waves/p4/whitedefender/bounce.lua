local Bounce, super = Class(Wave)

function Bounce:init()
    super:init(self)
    self.time = 10
    self:setArenaSize(260,140)
end

function Bounce:onStart()
    local arena = Game.battle.arena
    local dirt = self:spawnSprite("battle/p1/dungdefender/dirt", love.math.random(arena.left+50, arena.right-50), arena.bottom)
    dirt.layer = BATTLE_LAYERS["arena"]+1
    dirt:setOrigin(0.5, 1)
    dirt:play(0.1, true)

    local max = love.math.random(3,4)
    local i = 0
    self.timer:every(0.8, function()
        i = i+1
        if i == max then
            self:spawnBullet("p4/whitedefender/defbounce", dirt.x, dirt.y, -math.pi/2 + Utils.random(math.pi/8, math.pi/5)*Utils.randomSign())
        else
            self:spawnBullet("p1/dungdefender/dungbounce", dirt.x, dirt.y, -math.pi/2 + Utils.random(math.pi/8, math.pi/5)*Utils.randomSign())
        end
    end, max)
end

return Bounce