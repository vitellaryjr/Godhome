local Vessels, super = Class(Wave)

function Vessels:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(160, 120)
    self.vessels = {}
end

function Vessels:onStart()
    local arena, soul = Game.battle.arena, Game.battle.soul
    for _=1,2 do
        local anchor = Object(arena.x, -5)
        table.insert(self.vessels, anchor)
        self:addChild(anchor)
        anchor.sine = Utils.randomSign() * Utils.random(math.pi/3, math.pi/2)
        anchor.sine_speed = Utils.random(0.04, 0.07)
        anchor.rotation = math.pi/4*math.sin(anchor.sine)
        anchor.vessel = self:spawnBulletTo(anchor, "p5/wingednosk/vessel", 0, love.math.random(arena.top + 10, arena.bottom + 10))
    end
end

function Vessels:update()
    super:update(self)
    for _,anchor in ipairs(self.vessels) do
        local prev = anchor.sine
        anchor.sine = anchor.sine + anchor.sine_speed*DTMULT
        if Game.battle.wave_timer > 0.5 and (prev % (math.pi/2) > anchor.sine % (math.pi/2)) and (prev % math.pi < anchor.sine % math.pi) then
            anchor.vessel:fire()
        end
        anchor.rotation = math.pi/4*math.sin(anchor.sine)
    end
end

return Vessels