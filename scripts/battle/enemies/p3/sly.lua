local Sly, super = Class("boss")

function Sly:init()
    super:init(self)
    
    self.name = "Nailsage Sly"
    self:setActor("p3/sly")

    self.max_health = 900
    self.health = 900

    self.waves = {
        "p3/sly/fallnail",
        "p3/sly/dashslash",
        "p3/sly/cycloneslash",
        "p3/sly/greatslash",
    }

    self.text = {
        "* Sly would gladly go easy on you, in\nexchange for all of your Geo.",
        "* Sly is proud of his students for\nteaching you so well.",
        "* Candles flicker around you.",
    }

    self.final_done = false
end

function Sly:getNextWaves()
    if self.final_done then
        return {"p3/sly/chasenail"}
    else
        return super:getNextWaves(self)
    end
end

function Sly:onDefeat(damage, battler)
    if not self.final_done then
        Game.battle.encounter:stopMusic()
        self.final_done = true
        self.health = 80
        Game.battle:setWaves{"p3/sly/chasenail"}
        self.selected_wave = Game.battle.waves[1]

        local nail = Sprite("enemies/p3/sly/nail", self.x, self.y - 10)
        nail.layer = BATTLE_LAYERS["below_battlers"]
        nail:setScale(2)
        nail:setOrigin(0.5, 0.5)
        nail.graphics.spin = 0.4
        nail.physics.speed_y = -10
        Game.battle:addChild(nail)

        self:setAnimation("stagger")
        Game.battle.timer:after(0.7, function()
            self.physics = {
                speed_x = 20,
                friction = -1,
            }
            Game.battle.timer:tween(0.2, self, {alpha = 0, scale_x = 4, scale_y = 0})
        end)
    else
        self.physics = {}
        self.graphics = {}
        self:setScale(2)
        self:setPosition(540, 220)
        self:setAnimation("idle")
        Game.battle.encounter:stopMusic()
        Game.battle.timer:tween(0.2, self, {alpha = 1})
        super:onDefeat(self, damage, battler)
    end
end

return Sly