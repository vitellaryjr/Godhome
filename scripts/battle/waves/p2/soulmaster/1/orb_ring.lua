local Ring, super = Class(Wave)

function Ring:init()
    super:init(self)
    self.time = 4
end

function Ring:onStart()
    local arena = Game.battle.arena
    local dir = Utils.randomSign()
    local center = Object(arena.x + -dir*arena.width, arena.y)
    center.layer = BATTLE_LAYERS["bullets"]
    center.physics.speed_x = dir*3
    Game.battle:addChild(center)
    local angle = Utils.random(math.pi/2)
    for i=1,4 do
        self:spawnBulletTo(center, "p2/soulmaster/soulorb_ring", (arena.height/2)-12, angle + i*math.pi/2, dir*0.08)
    end
end

return Ring