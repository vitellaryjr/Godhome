local Crystal, super = Class("ordeal/zotebase")

function Crystal:init(x)
    local arena = Game.battle.arena
    super:init(self, x, arena.bottom + 32, "battle/ordeal/crystal")
    self:setOrigin(0.5, 1)
    self.color = {1,1,1}
end

function Crystal:onAdd(parent)
    super:onAdd(self, parent)
    local arena = Game.battle.arena
    local timer = Timer()
    self:addChild(timer)
    timer:tween(0.2, self, {y = arena.bottom}, "out-quad")
    timer:script(function(wait)
        wait(1.5)
        for _=1,5 do
            local laser = self.wave:spawnBulletTo(self, "common/crystal/laser", self.width/2, self.height/2, 8, 0.5)
            laser.rotation = -math.pi/2
            wait(3)
        end
        wait(3)
        timer:tween(0.2, self, {y = arena.bottom + 32}, "in-quad")
        wait(0.2)
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        self:remove()
    end)
end

function Crystal:hit(source, damage) end

return Crystal