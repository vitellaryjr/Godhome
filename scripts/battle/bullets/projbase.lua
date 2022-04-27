local Projectile, super = Class("nailbase")

function Projectile:init(x, y, sprite)
    super:init(self, x, y, sprite)
    self.color = {1, 0.6, 0.5}
    self.nail_flash = nil

    self.launched = false
end

function Projectile:update()
    super:update(self)
    if self.launched then
        if self:collidesWith(Game.battle.encounter.player_proj_hb) then
            self:launchHit(Game.battle:getPartyByID("knight"))
        end
        for _,enemy in ipairs(Game.battle.enemies) do
            if self:collidesWith(enemy.proj_hb) then
                self:launchHit(enemy)
                break
            end
        end
    end
end

function Projectile:hit(source, damage)
    self.launched = true
    super:hit(self, source, damage)
end

function Projectile:launchHit(battler)
    self.collidable = false
    if battler:includes(PartyBattler) then
        battler:hurt(self:getDamage())
    elseif battler:includes(EnemyBattler) then
        local player = Game.battle:getPartyByID("knight")
        local amount = self:getPlayerDamage(player.chara, battler)
        if battler.onNailHurt then
            battler:onNailHurt(amount, player)
        else
            battler.health = battler.health - amount
            battler.hurt_timer = 0.5
            battler.sprite.shake_x = 7
        end
    end
end

return Projectile