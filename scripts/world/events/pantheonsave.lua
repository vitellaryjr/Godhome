local Savepoint, super = Class(Event)

function Savepoint:init(data)
    super:init(self, data)

    self.solid = true

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/event/savepoint", 1/6)

    self.lifeblood = 0
    if Game:getFlag("lifeblood_active", false) then
        local complete = Mod:getBindingCount()
        if complete >= 16 then
            self.lifeblood = 40
        elseif complete >= 12 then
            self.lifeblood = 30
        elseif complete >= 8 then
            self.lifeblood = 20
        end
        self.sprite.color = {0.7,0.8,1}
    end
end

function Savepoint:onInteract(player, dir)
    Assets.playSound("snd_power")
    for _,party in ipairs(Game.party) do
        party:heal(math.huge, false)
    end
    if self.lifeblood > 0 then
        local chara = Game:getPartyMember("knight")
        chara.lifeblood = chara.lifeblood + self.lifeblood
        local mask = ColorMaskFX({0.5,0.7,1}, 1)
        player:addFX(mask)
        Game.world.timer:tween(1, mask, {amount = 0}, "linear", function()
            player:removeFX(mask)
        end)
        self.lifeblood = 0
        self.sprite.color = {1,1,1}
    end
    Game.world:showText("* You rest at the hot spring.\n* HP restored.")
    return true
end

return Savepoint