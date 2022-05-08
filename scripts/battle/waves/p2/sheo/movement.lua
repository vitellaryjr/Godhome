local Movement, super = Class(Wave)

function Movement:init()
    super:init(self)
    self.time = 7
    self:setArenaOffset(-40,0)
end

function Movement:onStart()
    local arena = Game.battle.arena
    local sheo = Game.battle:getEnemyBattler("p2/sheo")
    self.timer:tween(0.5, sheo, {x = 540}, "out-quad")
    self.timer:everyInstant(2, function()
        self.timer:script(function(wait)
            local type = Utils.pick{"cyan", "orange"}
            sheo:setAnimation("raise_"..type)
            local fx, fy = 16,-25 -- there really isnt a better way to do this other than magic numbers
            local flare = Sprite("battle/p2/sheo/flare_"..type, fx, fy)
            flare:setOrigin(0.5, 0.5)
            sheo:addChild(flare)
            flare:play(0.05, false, flare.remove)
            local ps = ParticleAbsorber(fx, fy, {
                layer = BATTLE_LAYERS["below_battlers"],
                color = (type == "orange") and {1, 0.6, 0} or {0, 1, 1},
                size = {4,6},
                fade_in = 0.2,
                move_time = 0.5,
                dist = 32,
                every = 0.2,
                time = 1,
                amount = {1,2},
            })
            sheo:addChild(ps)
            local slash = self:spawnBullet("p2/sheo/colorslash", arena.x, arena.y, type)
            wait(1)
            ps:clear()
            ps:remove()
            Game.battle.shake = 4
            sheo:setAnimation("slam_"..type)
            slash:slash()
            wait(0.5)
            local xs = {}
            for _=1,4 do
                local x = love.math.random(arena.left, arena.right)
                table.insert(xs, x)
                local drop = DropSprite(x, -10, (type == "orange") and {1, 0.6, 0} or {0, 1, 1})
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
end

function Movement:onEnd()
    local sheo = Game.battle:getEnemyBattler("p2/sheo")
    Game.battle.timer:tween(0.2, sheo, {x = 520}, "linear")
    sheo:setAnimation("idle")
end

return Movement