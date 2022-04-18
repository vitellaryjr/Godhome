local Guardian, super = Class("bossEncounter")

function Guardian:init()
    super:init(self)

    table.insert(self.bosses, self:addEnemy("p4/enragedguardian", 540, 220))

    self.text = "* The Crystal Guardian is angy"
    self.pantheon_music = "pantheon_a"

    self.background = false
    self.hide_world = true
end

function Guardian:onBattleStart()
    super:onBattleStart(self)
    local bg = CrystalBG()
    bg.fill = {0.07, 0.03, 0.05}
    bg.color = {0.4, 0.15, 0.4}
    bg.back_color = {0.27, 0.11, 0.2}
    Game.battle:addChild(bg)
    Game.battle:addChild(EnragedCrystalClusters())
    local sprite = Sprite("battle/p4/enragedguardian/bg_crystals", 0,0)
    sprite:setOrigin(0,1)
    sprite:setRotationOrigin(0.5,1)
    sprite.rotation = math.pi
    Game.battle:addChild(sprite)
end

return Guardian