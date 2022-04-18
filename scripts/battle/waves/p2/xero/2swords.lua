local Swords, super = Class(Wave)

function Swords:init()
    super:init(self)
    self.time = 8
    self:setArenaSize(180)

    self.swords = {}
end

function Swords:onStart()
    local arena = Game.battle.arena
    local xero = self:spawnBullet("p2/xero/xero", arena.x, arena.top + 20)

    local sword_pos = {
        {-40, 0},
        { 40, 0},
    }
    for _,pos in ipairs(sword_pos) do
        local sword = self:spawnBullet("p2/xero/sword", xero, pos[1], pos[2], false)
        table.insert(self.swords, sword)
    end

    self.timer:every(1.2, function()
        local sword = Utils.pick(self.swords, function(a) return a.state == "idle" end)
        if sword then
            sword:attack()
        end
    end)
end

return Swords