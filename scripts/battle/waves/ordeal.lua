local Ordeal, super = Class(Wave)

function Ordeal:init()
    super:init(self)
    self.time = -1
    self:setArenaSize(320, 180)
    self:setArenaPosition(320, 240)

    -- index = how many kills necessary for it to spawn, value = info about enemy
    self.zote_types = {
        [0] = {name = "zoteling"},
        [1] = {name = "fly"},
        [2] = {name = "hopper"},
        [5] = {name = "heavy"},
        [15] = {name = "turret", enter = function(arena, soul)
            return self:spawnBulletTo(Game.battle.mask, "ordeal/turret", love.math.random(arena.left + 10, arena.right - 10))
        end},
        [20] = {name = "lanky"},
        [25] = {name = "head", enter = function(arena, soul)
            return self:spawnBulletTo(Game.battle.mask, "ordeal/head", love.math.random(arena.left + 50, arena.right - 50))
        end},
        [30] = {name = "volatile", enter = function(arena, soul)
            local x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            while math.abs(soul.x - x) < 20 and math.abs(soul.y - y) < 20 do
                x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            end
            return self:spawnBullet("ordeal/volatile", x, y)
        end},
        [35] = {name = "fluke", enter = function(arena, soul)
            local x = love.math.random(arena.left + 30, arena.right - 30)
            while math.abs(soul.x - x) < 30 do
                x = love.math.random(arena.left + 30, arena.right - 30)
            end
            return self:spawnBulletTo(Game.battle.mask, "ordeal/fluke", x)
        end},
        [40] = {name = "curse", enter = function(arena, soul)
            return self:spawnBullet("ordeal/curse", arena.x, arena.top + arena.height/4)
        end},
        [60] = {name = "ceiling", enter = function(arena, soul)
            return self:spawnBulletTo(Game.battle.mask, "ordeal/ceiling", love.math.random(arena.left + 10, arena.right - 10))
        end},
        [70] = {name = "crystal", enter = function(arena, soul)
            local x = love.math.random(arena.left + 30, arena.right - 30)
            while math.abs(soul.x - x) < 30 do
                x = love.math.random(arena.left + 30, arena.right - 30)
            end
            return self:spawnBulletTo(Game.battle.mask, "ordeal/crystal", x)
        end},
        [80] = {name = "void", enter = function(arena, soul)
            local x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            while math.abs(soul.x - x) < 40 and math.abs(soul.y - y) < 40 do
                x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            end
            return self:spawnBulletTo(Game.battle.mask, "ordeal/void", x, y)
        end},
        [90] = {name = "rolling"},
        [100] = {name = "aspid"},
        [110] = {name = "bike", enter = function(arena, soul)
            return self:spawnBullet("ordeal/bike", 700, soul.y)
        end},
        [120] = {name = "soul", enter = function(arena, soul)
            local x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            while math.abs(soul.x - x) < 40 and math.abs(soul.y - y) < 40 do
                x, y = love.math.random(arena.left + 50, arena.right - 50), love.math.random(arena.top + 50, arena.bottom - 50)
            end
            return self:spawnBullet("ordeal/soul", x, y)
        end},
        [130] = {name = "wall", enter = function(arena, soul)
            if soul.x < arena.x then
                return self:spawnBulletTo(Game.battle.mask, "ordeal/wall", arena.x + (arena.width/2 + 16))
            else
                return self:spawnBulletTo(Game.battle.mask, "ordeal/wall", arena.x - (arena.width/2 + 16))
            end
        end},
        [140] = {name = "gpz", enter = function(arena, soul)
            return self:spawnBullet("ordeal/gpz")
        end},

        ["nkz"] = {name = "nkz", enter = function(arena, soul)
            if soul.x < arena.x then
                return self:spawnBullet("ordeal/nkz", arena.right - 50, arena.top + 50)
            else
                return self:spawnBullet("ordeal/nkz", arena.left + 50, arena.top + 50)
            end
        end},
        ["bigzote"] = {name = "BIGZOTE", enter = function(arena, soul)
            if soul.x < arena.x then
                return self:spawnBullet("ordeal/bigzote", arena.right - 40, -50)
            else
                return self:spawnBullet("ordeal/bigzote", arena.left + 40, -50)
            end
        end},
    }
    self.current_types = {self.zote_types[0]}
    -- defines how many enemies are allowed at once, depending on how many have been killed
    self.amount_allowed = {
        [1] = 2,
        [2] = 3,
        [15] = 4,
        [40] = 5,
    }
    self.current_max = 1
    self.amount_of_type_allowed = {
        heavy = 1,
        lanky = 1,
        head = 1,
        bike = 1,
        gpz = 1,
    }

    self.boss_stage = 0
    self.nkz_max = 0
    self.bigzote_max = 0

    self.zotes = {}
    self.zotes_by_type = {}

    -- if you wanna skip ahead, change this number and uncomment the function after
    self.kill_count = 0
    -- self:calculateState()
end

function Ordeal:onStart()
    -- print("start")
    local arena, soul = Game.battle.arena, Game.battle.soul
    self.timer:script(function(wait)
        wait(2)
        while true do
            if #self.zotes < self.current_max then
                local zote_type = Utils.pick(self.current_types, function(v)
                    if not self.zotes_by_type[v.name] then
                        return true
                    else
                        return #self.zotes_by_type[v.name] < (self.amount_of_type_allowed[v.name] or 2)
                    end
                end)
                if zote_type then
                    self:spawnZote(zote_type)
                end
            end
            local time = Utils.clampMap(self.kill_count, 0,30, 3,1)
            while time > 0 do
                wait(1)
                time = time - 1
                if #self.zotes == 0 then break end
            end
        end
    end)
    -- responsible for doing boss stuff
    self.timer:script(function(wait)
        while true do
            local total_zotes = #self.zotes + self.kill_count
            if self.boss_stage == 0 then
                if total_zotes > 250 then
                    self.current_max = math.min(256 - self.kill_count, 5)
                    if self.kill_count == 256 then
                        wait(2)
                        local nkz = self:spawnZote(self.zote_types["nkz"])
                        while nkz.stage do
                            wait()
                        end
                        self.boss_stage = 1
                        self.current_max = 5
                    end
                end
            elseif self.boss_stage == 1 then
                self.nkz_max = math.min(math.floor((total_zotes - 256) / 64), 4)
                if total_zotes > 256 and total_zotes % 64 < 5 and self.kill_count % 64 >= 5 then
                    self.current_max = math.min(64 - (self.kill_count%64) + self.nkz_max, 5)
                end
                if self.kill_count > 256 and self.kill_count % 64 == 0 and self.kill_count % 512 ~= 0 then
                    local nkz = self:spawnZote(self.zote_types["nkz"])
                    while nkz.stage do
                        wait()
                    end
                    self.current_max = 5
                    if self.kill_count > 448 then
                        self.boss_stage = 2
                    end
                end
            elseif self.boss_stage == 2 then
                self.bigzote_max = math.min(math.floor(total_zotes / 570) - 1, 4)
                if total_zotes % 570 < 5 and self.kill_count % 570 >= 5 then
                    self.current_max = math.min(570 - (self.kill_count%570) + self.bigzote_max, 5)
                end
                if self.kill_count % 570 == 0 then
                    if self.kill_count == 570 then
                        self.current_max = 0
                        wait(1)
                    end
                    local bigzote = self:spawnZote(self.zote_types["bigzote"])
                    while bigzote.stage do
                        wait()
                    end
                    self.current_max = 5
                else
                    if (total_zotes%570) % 128 < 5 and (self.kill_count%570) % 128 >= 5 and (total_zotes%570) % 512 >= 5 then
                        self.current_max = 5
                    end
                    if (self.kill_count%570) % 128 == 0 and (self.kill_count%570) % 512 ~= 0 then
                        local nkz = self:spawnZote(self.zote_types["nkz"])
                        while nkz.stage do
                            wait()
                        end
                        self.current_max = 5
                    end
                end
            end
            wait()
        end
    end)
end

function Ordeal:spawnZote(zote)
    local arena = Game.battle.arena
    if zote.enter then
        local bullet = zote.enter(arena, Game.battle.soul)
        bullet.zote_type = zote.name
        if bullet.nail_tp then
            bullet.nail_tp = bullet.nail_tp * Utils.clampMap(self.kill_count, 0,30, 1,0.3)
        else
            bullet.tp = bullet.tp * Utils.clampMap(self.kill_count, 0,30, 1,0.3)
        end
        table.insert(self.zotes, bullet)
        if not self.zotes_by_type[zote.name] then
            self.zotes_by_type[zote.name] = {}
        end
        table.insert(self.zotes_by_type[zote.name], bullet)
        return bullet
    else
        local x = love.math.random(arena.left + 10, arena.right - 10)
        self:spawnBulletTo(Game.battle.mask, "ordeal/zotespawn", x, arena.top - 10, zote.name)
    end
end

function Ordeal:increaseKillCount()
    self.kill_count = self.kill_count + 1
    if self.zote_types[self.kill_count] then
        table.insert(self.current_types, self.zote_types[self.kill_count])
    end
    if self.amount_allowed[self.kill_count] then
        self.current_max = self.amount_allowed[self.kill_count]
    end
    if self.kill_count == 40 then
        self.amount_of_type_allowed["zoteling"] = 1
    end
    Game.battle.zote_ui:setCount(self.kill_count)
end

function Ordeal:calculateState()
    self.current_types = {}
    self.current_max = 1
    for i=0,self.kill_count do
        if self.zote_types[i] then
            table.insert(self.current_types, self.zote_types[i])
        end
        if self.amount_allowed[i] then
            self.current_max = self.amount_allowed[i]
        end
    end
    if self.kill_count < 256 then
        self.boss_stage = 0
    elseif self.kill_count < 448 then
        self.boss_stage = 1
    else
        self.boss_stage = 2
    end
    if self.kill_count > 100 then
        self.amount_of_type_allowed["zoteling"] = 0
        self.amount_of_type_allowed["lanky"] = 1
    elseif self.kill_count > 40 then
        self.amount_of_type_allowed["zoteling"] = 1
    end
    Game.battle.zote_ui:setCount(self.kill_count)
end

return Ordeal