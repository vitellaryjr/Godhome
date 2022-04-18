local Jump, super = Class("nailbase")

function Jump:init(x, y, dir_x, dir_y)
    super:init(self, x, y, "battle/p1/mosscharger/mossy")
    self:setOrigin(0.5, 1)
    self:setScale(dir_x*2, dir_y*2)
    self:setHitbox(17,12,47,30)
    self.sprite:play(0.15, true)
    self.physics.speed_x = dir_x*9

    self.enemy = Game.battle:getEnemyByID("p1/mosscharger")

    self.dir_x = dir_x
    self.dir_y = dir_y
end

function Jump:update(dt)
    super:update(self, dt)
    local arena = Game.battle.arena
    local x, y, w, h = arena.x, arena.y, arena.width/2, arena.height/2
    if Utils.sign(self.x - arena.x) == -self.dir_x then
        if self.x > arena.x then
            self.y = Utils.clampMap(self.x, x,x+(w+50)*-self.dir_x, y+h*0.2*-self.dir_y,y+h*self.dir_y, "in-sine")
        else
            self.y = Utils.clampMap(self.x, x+(w+50)*-self.dir_x,x, y+h*self.dir_y,y+h*0.2*-self.dir_y, "out-sine")
        end
    else
        if self.x < arena.x then
            self.y = Utils.clampMap(self.x, x+(w+20)*self.dir_x,x, y+h*self.dir_y,y+h*0.2*-self.dir_y, "out-sine")
        else
            self.y = Utils.clampMap(self.x, x,x+(w+20)*self.dir_x, y+h*0.2*-self.dir_y,y+h*self.dir_y, "in-sine")
        end
    end
end

return Jump