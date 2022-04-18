local GreatSlash, super = Class(Wave)

function GreatSlash:init()
    super:init(self)
    self.time = 7
    self:setArenaSize(140)
end

function GreatSlash:onStart()
    local arena = Game.battle.arena
    self.timer:after(0.5, function()
        self.timer:everyInstant(2, function()
            self:spawnBullet("p2/sheo/greatslash", arena.x, arena.y, love.math.random(4))
        end)
        self.timer:after(1.3, function()
            self.timer:everyInstant(2, function()
                self.timer:script(function(wait)
                    local xs = {}
                    for _=1,4 do
                        local x = love.math.random(arena.left, arena.right)
                        table.insert(xs, x)
                        local drop = DropSprite(x, -10, {1, 0.4, 0.8})
                        drop.layer = BATTLE_LAYERS["below_bullets"]
                        Game.battle:addChild(drop)
                    end
                    for _,x in ipairs(xs) do
                        local blob = self:spawnBullet("p2/sheo/paintblob", x, -8)
                        blob.physics = {
                            speed = 2,
                            direction = math.pi/2,
                            gravity = 0.4,
                            gravity_direction = math.pi/2,
                        }
                        wait(Utils.random(0.2, 0.4))
                    end
                end)
            end)
        end)
    end)
end

return GreatSlash