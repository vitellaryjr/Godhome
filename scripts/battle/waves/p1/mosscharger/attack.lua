local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)

    self.time = 4.5
    self:setArenaSize(240, 140)
end

function Charge:onStart()
    local arena = Game.battle.arena
    local dir_x, dir_y = Utils.randomSign(), Utils.randomSign()
    local type = love.math.random() < 0.5 and "charge" or "jump"
    self.timer:after(0.2, function()
        self:addChild(GrassPuff(
            arena.x + arena.width/2*-dir_x, arena.y, arena.height, Vector.toPolar(dir_x, 0),
            type == "charge" and math.pi/2 or (Vector.toPolar(dir_x, dir_y) + (dir_y == -1 and math.pi or 0))
        ))
    end)
    self.timer:after(1.5, function()
        self:spawnBulletTo(Game.battle.mask, "p1/mosscharger/"..type,
            arena.x + (arena.width/2 + 50)*-dir_x, arena.y + arena.height/2*dir_y, dir_x, dir_y
        )
    end)
end

return Charge