local Gem, super = Class(Object)

function Gem:init(pantheon, x, y, notches)
    super:init(self, x, y)
    self:setScale(2)

    local gem_path = "gem"
    local bindings = Game:getFlag("pantheon_bindings", {})[tostring(pantheon)] or {}
    if Game:getFlag("pantheon_complete", {})[tostring(pantheon)] then
        if bindings.hp and bindings.nail and bindings.tp and bindings.magic then
            gem_path = gem_path .. "_bindings"
            self.bindings = true
        end

        if Game:getFlag("pantheon_hitless", {})[tostring(pantheon)] then
            gem_path = gem_path .. "_hitless"
            self.hitless = true
        end
        
        if gem_path == "gem" then
            gem_path = "gem_active"
        end
        self.complete = true
    else
        gem_path = "gem_inactive"
    end
    self.sprite = Sprite("tilesets/doors/"..gem_path)
    self.sprite.layer = 1
    self.sprite:setOrigin(0.5, 0.5)
    self:addChild(self.sprite)

    self.bindings = {}
    local bindnames = {"magic", "hp", "tp", "nail"}
    for i,v in ipairs(bindnames) do
        local pos = notches[i] or {0,0}
        local bx, by = unpack(pos)
        local path = "tilesets/doors/bindgem_"..v
        if bindings[v] then
            if bindings.hp and bindings.nail and bindings.tp and bindings.magic then
                path = path.."_glow"
            else
                path = path.."active"
            end
        end
        local bind = Sprite(path, bx, by)
        bind.layer = 1
        bind:setOrigin(0.5, 0.5)
        self:addChild(bind)
        self.bindings[v] = bind
    end
end

function Gem:onAdd(parent)
    super:onAdd(self, parent)
    if self.hitless then
        self:addChild(ParticleEmitter(0, 0, {
            layer = parent.layer + 10,
            shape = "circle",
            color = {0,0,0},
            alpha = {0.7,1},
            size = {4,10},
            speed_x = {-0.2,0.2},
            speed_y = {-0.5,-1},
            shrink = {0.01,0.05},
            shrink_after = {1,2},
            amount = 1,
            every = {0.3,0.5},
        }))
    end
end

return Gem