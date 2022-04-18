local Chase, super = Class(Wave)

function Chase:init()
    super:init(self)
    self.time = -1
    self:setArenaSize(210)
end

function Chase:onStart()
    local arena = Game.battle.arena
    Game.battle.encounter:playMusic("pantheon_c")
    self:spawnBullet("p3/sly/chasenail", arena.x, -50)
end

return Chase