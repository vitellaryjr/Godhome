local Statue, super = Class(InteractScript)

function Statue:init(data)
    super:init(self, "enter_god", data.x, data.y, data.width, data.height)
    self.encounter = data.properties.encounter
    self.sprite = Sprite("tilesets/statues/"..self.encounter, data.width/2, -10)
    self.sprite:setOrigin(0.5, 1)
    self.sprite:setScale(2)
    self:addChild(self.sprite)

    self.name = data.properties.name
    self.description = data.properties.desc or data.properties.description

    self.difficulty_sprite = Sprite("tilesets/statues/difficulty_none", data.width/2, data.height - 10)
    self.difficulty_sprite:setOrigin(0.5, 1)
    self.difficulty_sprite:setScale(2)
    self:addChild(self.difficulty_sprite)
    local clear = Game:getFlag("hall_clear", {})[self.encounter]
    if clear then
        self.difficulty_sprite:setTexture("tilesets/statues/difficulty_"..clear)
    end

    if data.properties.locked and not Game:getFlag("hall_unlocked", {})[self.encounter] then
        self.locked = true
        self.sprite.visible = false
        self.difficulty_sprite:setTexture("tilesets/statues/difficulty_text")
    end

    self.alt_encounter = data.properties.alt_encounter
    if self.alt_encounter then
        self.lever = Sprite("tilesets/statues/dream_lever_off", data.width, 10)
        self.lever:setOrigin(0.5, 1)
        self.lever:setScale(2)
        self:addChild(self.lever)

        self.alt_name = data.properties.alt_name
        self.alt_description = data.properties.alt_desc or data.properties.alt_description

        self.difficulty_sprite.x = data.width/2 - 20
        self.alt_difficulty_sprite = Sprite("tilesets/statues/difficulty_none", data.width/2 + 20, data.height - 10)
        self.alt_difficulty_sprite:setOrigin(0.5, 1)
        self.alt_difficulty_sprite:setScale(2)
        self:addChild(self.alt_difficulty_sprite)
        local alt_clear = Game:getFlag("hall_clear", {})[self.alt_encounter]
        if alt_clear then
            self.alt_difficulty_sprite:setTexture("tilesets/statues/difficulty_"..alt_clear)
        end

        if data.properties.alt_locked and not Game:getFlag("hall_unlocked", {})[self.alt_encounter] then
            self.alt_locked = true
            self.lever:remove()
            self.alt_difficulty_sprite:setTexture("tilesets/statues/difficulty_text")
        end

        if data.properties.alt_dream then
            self.dream = true
        elseif data.properties.alt_nightmare then
            self.nightmare = true
        end
    end

    self.asc_encounter = data.properties.asc_encounter

    self.alt_active = false
    if Game:getFlag("hall_alt_active", {})[self.encounter] then
        self:toggleAltState(true)
    end
end

function Statue:onInteract(chara, facing)
    if self.alt_encounter and not self.alt_locked then
        if (chara.x > self.x + (self.width - 20)) or (facing == "left") then
            self:toggleAltState()
            return
        end
    end
    super:onInteract(self, chara, facing)
end

function Statue:toggleAltState(silent)
    self.alt_active = not self.alt_active
    if not silent then
        Assets.playSound("dream_lever")
    end
    local flag = Game:getFlag("hall_alt_active", {})
    flag[self.encounter] = self.alt_active
    Game:setFlag("hall_alt_active", flag)

    if self.alt_active then
        if self.dream then
            self.dream_ps = ParticleEmitter(self.x, self.y - self.sprite.height, self.width, self.sprite.height, {
                layer = self.layer + 1,
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.95,0.7},
                alpha = {0.2,0.3},
                blend = "add",
                fade_in = 0.01,
                fade = 0.01,
                fade_after = {0.5,1},
                speed_y = {-2,-3},
                spin_var = math.rad(1),
                amount = {5,6},
                every = 0.5,
            })
            Game.world:addChild(self.dream_ps)
        elseif self.nightmare then
            self.dream_ps = ParticleEmitter(self.x, self.y - self.sprite.height, self.width, self.sprite.height, {
                layer = self.layer + 1,
                path = "battle/misc/dream",
                shape = {"small_a", "small_b"},
                color = {1,0.2,0.2},
                alpha = {0.2,0.3},
                blend = "add",
                fade_in = 0.01,
                fade = 0.01,
                fade_after = {0.5,1},
                speed_y = {-2,-3},
                spin_var = math.rad(1),
                amount = {5,6},
                every = 0.5,
            })
            Game.world:addChild(self.dream_ps)
        end
        self.lever:setSprite("tilesets/statues/dream_lever_on")
    else
        if self.dream and self.dream_ps then
            self.dream_ps:remove()
            self.dream_ps = nil
        end
        self.lever:setSprite("tilesets/statues/dream_lever_off")
    end
end

function Statue:getEncounter(difficulty, return_id)
    if self.alt_active then
        return self.alt_encounter
    else
        if self.asc_encounter and difficulty ~= "attuned" and not return_id then
            return self.asc_encounter
        else
            return self.encounter
        end
    end
end

function Statue:getText()
    if self.alt_active then
        return self.alt_name, self.alt_description or self.description
    else
        if self.locked then
            return "???", self.description
        else
            return self.name, self.description
        end
    end
end

return Statue