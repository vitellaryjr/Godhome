local Conveyor, super = Class(Object)

function Conveyor:init(speed, dir, height)
    local arena = Game.battle.arena
    super:init(self, arena.x, arena.y)
    self.layer = -100
    self.speed = speed
    self.dir = dir
    self.belts = {}
    for i=0,math.ceil(math.max(arena.width, arena.height)/20)+1 do
        local sprite = Sprite("battle/p5/kristalguardian/conveyor")
        sprite:setPosition(math.cos(dir)*i*20, math.sin(dir)*i*20)
        sprite:setOrigin(0.5, 0.5)
        sprite.rotation = dir
        sprite.scale_y = height/160
        self:addChild(sprite)
        table.insert(self.belts, sprite)
    end
    self.shards = {}
end

function Conveyor:update(dt)
    super:update(self, dt)
    local arena, soul = Game.battle.arena, Game.battle.soul
    soul:move(math.cos(self.dir), math.sin(self.dir), self.speed*DTMULT)
    for _,belt in ipairs(self.belts) do
        belt:move(math.cos(self.dir), math.sin(self.dir), self.speed*DTMULT)
        if math.max(math.abs(belt.x), math.abs(belt.y)) > math.max(arena.width/2, arena.height/2) then
            belt:move(math.cos(self.dir), math.sin(self.dir), -math.max(arena.width, arena.height))
        end
    end
    for _,shard in ipairs(self.shards) do
        shard:move(math.cos(self.dir), math.sin(self.dir), self.speed*DTMULT)
    end
end

function Conveyor:addShard(shard)
    table.insert(self.shards, shard)
end

return Conveyor