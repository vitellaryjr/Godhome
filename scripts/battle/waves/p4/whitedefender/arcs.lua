local Arcs, super = Class(Wave)

function Arcs:init()
    super:init(self)
    self.time = 4
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
    self.timer:during(Utils.random(0.7,1), function()
        dirt.x = dirt.x + speed*dir*DTMULT
        if dirt.x < arena.left+50 then
            dir = 1
        elseif dirt.x > arena.right-50 then
            dir = -1
        end
    end, function()
        local ps
        if dirt.x > arena.x then
            ps = ParticleEmitter(arena.left, arena.top, 0, arena.height, {
                layer = "above_arena",
                color = {{0.5, 0.5, 0.5}, {0.7, 0.7, 0.7}},
                size = {4,6},
                angle = 0,
                speed = {2,4},
                shrink = 0.07,
                shrink_after = {0,0.2},
                amount = {3,4},
                every = 0.1,
            })
        else
            ps = ParticleEmitter(arena.right, arena.top, 0, arena.height, {
                layer = "above_arena",
                color = {{0.5, 0.5, 0.5}, {0.7, 0.7, 0.7}},
                size = {4,6},
                angle = math.pi,
                speed = {2,4},
                shrink = 0.07,
                shrink_after = {0,0.2},
                amount = {3,4},
                every = 0.1,
            })
        end
        self:addChild(ps)
        self.timer:after(0.7, function()
            ps:remove()
            for i=1,8 do
                local sx = Utils.clampMap(i, 1,8, -1,1)*6
                self:spawnBullet("p1/dungdefender/dungarc", dirt.x, dirt.y, sx)
            end
            dirt:play(0.15, false)
            self.timer:script(function(wait)
                local sx, sdir
                if dirt.x > arena.x then
                    sx = arena.left + 10
                    sdir = 1
                else
                    sx = arena.right - 10
                    sdir = -1
                end
                for i=0,2 do
                    self:spawnBulletTo(Game.battle.mask, "p4/whitedefender/spike", sx + i*35*sdir, arena.bottom, sdir)
                    wait(0.15)
                end
            end)
        end)
    end)
end

return Arcs