local Bike, super = Class(Bullet)

function Bike:init(x, y)
    super:init(self, x, y, "battle/ordeal/bike")
    self.sprite:play(0.1, true)
    self:setHitbox(16,13, 8,25)

    self.charging = false
end

function Bike:onAdd(parent)
    super:onAdd(self, parent)
    self.wave.timer:script(function(wait)
        for _=1,2 do
            Assets.playSound("ordeal/bike_honk")
            local honk = Sprite("battle/ordeal/bike_honk", 625, self.y)
            honk:setLayer(BATTLE_LAYERS["below_bullets"])
            honk:setScaleOrigin(1, 0.5)
            Game.battle:addChild(honk)
            honk.graphics = {
                grow_x = 0.2,
                grow_y = 0.2,
                fade_to = 0,
                fade = 0.1,
                fade_callback = honk.remove,
            }
            wait(0.15)
        end
        wait(0.3)
        Assets.playSound("ordeal/bike_drive")
        self.physics = {
            speed_x = -16
        }
        self.charging = true
        local arena = Game.battle.arena
        while not self:collidesWith(arena.collider.colliders[4]) do
            wait()
        end
        Utils.removeFromTable(self.wave.zotes, self)
        Utils.removeFromTable(self.wave.zotes_by_type[self.zote_type], self)
        local zote = self.wave:spawnBullet("ordeal/zoteling", self.x)
        zote.zote_type = "zoteling"
        table.insert(self.wave.zotes, zote)
        if not self.wave.zotes_by_type.zoteling then
            self.wave.zotes_by_type.zoteling = {}
        end
        table.insert(self.wave.zotes_by_type.zoteling, zote)

        zote.y = self.y
        self:explode()
        zote.physics = {
            speed_x = Utils.random(4,8),
            speed_y = -6,
            gravity = 0.4,
            gravity_direction = math.pi/2,
        }
        zote:shiftOrigin(0.5, 0.5)
        zote:setSprite("battle/ordeal/zoteling_roll")
        zote.collider = CircleCollider(zote, zote.width/2, zote.height/2, 4)
        zote.graphics.spin = 0.5
        zote.rolling = true
    end)
end

function Bike:update()
    super:update(self)
    if self.charging then
        for _,zote in ipairs(self.wave.zotes) do
            if zote ~= self and not zote.immune and zote:collidesWith(self) then
                zote.active = false
                zote:setScaleOrigin(0.5, 1)
                Assets.playSound("ordeal/bike_splat")
                self.wave.timer:tween(0.1, zote, {scale_y = 0})
                Utils.removeFromTable(self.wave.zotes, zote)
                Utils.removeFromTable(self.wave.zotes_by_type[zote.zote_type], zote)
                self.wave:increaseKillCount()
            end
        end
    end
end

return Bike