local Tamer, super = Class("nailbase")

function Tamer:init(x, tx, time)
    super:init(self, x, 360, "battle/p3/godtamer/tamer_leap")
    self.sprite:stop()
    self.layer = BATTLE_LAYERS["below_ui"]
    self.collider = ColliderGroup(self, {
        Hitbox(self, 32,16,4,12),
    })
    
    self.knockback = 6
    self.enemy = Game.battle:getEnemyByID("p3/godtamer")

    self.physics = {
        speed_x = (tx-x)/(time*30),
        speed_y = -15,
        gravity = 0.4,
        gravity_direction = math.pi/2,
    }

    self.falling = false
end

function Tamer:update(dt)
    super:update(self, dt)
    if self.y < 300 then
        self:setLayer(BATTLE_LAYERS["bullets"])
    else
        self:setLayer(BATTLE_LAYERS["below_ui"])
    end

    if not self.falling and self.physics.speed_y > 0 then
        self.falling = true
        self.sprite:play(0.05, false, function()
            table.insert(self.collider.colliders, LineCollider(self, 29,25, 3,30))
        end)
    end
end

return Tamer