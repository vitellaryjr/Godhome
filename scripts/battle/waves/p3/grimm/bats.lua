local Bats, super = Class(Wave)

function Bats:init()
    super:init(self)
    self.time = 7
end

function Bats:onStart()
    local arena = Game.battle.arena
    local soul = Game.battle.soul
    self.timer:every(0.8, function()
        local dir = 0
        if soul.x == arena.x then
            dir = Utils.randomSign()
        else
            dir = Utils.sign(soul.x - arena.x)
        end
        local x, y = arena.x + arena.width*-dir, arena.y
        self:spawnBullet("p3/grimm/firebat", x, y, dir, soul.y)
        Game.battle:addChild(ParticleEmitter(x, y, {
            layer = BATTLE_LAYERS["above_bullets"],
            shape = "triangle",
            color = {1,0.2,0.2},
            alpha = {0.5,0.8},
            blend = "screen",
            size = {8,32},
            spin_var = 0.2,
            speed = {2,4},
            friction = 0.2,
            fade = 0.04,
            fade_after = 0.1,
            amount = {16,20},
            draw = function(p, orig)
                local r, g, b = unpack(p.color)
                local a = p.alpha
                love.graphics.setColor(r*a, g*a, b*a)
                orig:draw(p)
            end,
        }))
    end)
end

return Bats