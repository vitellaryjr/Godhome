local VengefulSpirit, super = Class(Spell)

function VengefulSpirit:init()
    super:init(self)

    self.name = "Vengeful Spirit"
    self.effect = "Burning\nsoul"
    self.description = "A spirit that will fly forward and burn foes\nin its path."

    self.cost = 16

    self.target = "enemy"
    self.tags = {"attack"}
end

function VengefulSpirit:getCastMessage(user, target)
    return "* You cast VENGEFUL SPIRIT!"
end

function VengefulSpirit:onCast(user, target)
    user.sprite.shake_x = 4
    Game.battle.timer:tween(0.5, user.sprite, {shake_x = 0})
    Assets.playSound("player/fireball", 1)
    local fireball = Sprite("party/knight/battle/spirit", user.x, user.y - user.height)
    fireball.layer = BATTLE_LAYERS["above_battlers"]
    fireball:setOrigin(0.5, 0.5)
    fireball:setScale(2)
    fireball.rotation = Utils.angle(user, target)
    Game.battle:addChild(fireball)
    fireball:play(0.1, true)
    Game.battle.timer:after(0.05, function()
        fireball:addChild(ParticleEmitter(0,10, fireball.width, fireball.height*2-10, {
            layer = BATTLE_LAYERS["above_battlers"] - 10,
            shape = "circle",
            color = {{1,1,1}, {0,0,0}},
            alpha = {0.3,0.5},
            size = {4,5},
            speed = {1,2},
            angle = fireball.rotation + math.pi,
            fade = 0.04,
            fade_after = 0.5,
            amount = {2,3},
            every = 0.02,
        }))
    end)
    Game.battle.timer:everyInstant(0.02, function()
        fireball:addChild(AfterImage(fireball, 0.3, 0.1))
    end, 15)
    Game.battle.timer:tween(0.3, fireball, {x = target.x, y = target.y - target.height}, "linear", function()
        fireball:remove()
        Assets.playSound("player/enemy_damage", 0.7)
        target:flash()
        local damage = user.chara:getStat("magic")*10 - target.defense*3
        if damage > 0 then
            target:hurt(damage, user)
        else
            target:statusMessage("msg", "miss")
        end
    end)
end

return VengefulSpirit