local Particle, P_super = Class(Sprite)

function Particle:init(texture, x, y)
    P_super:init(self, texture, x, y)
    self:setOrigin(0.5, 0.5)
end

function Particle:update()
    if self.update_func then self:update_func() end
    P_super:update(self)
end

function Particle:draw()
    if self.pre_draw_func then self:pre_draw_func() end
    if self.blend ~= "alpha" and self.blend ~= "add" then
        love.graphics.setBlendMode(self.blend, "premultiplied")
    else
        love.graphics.setBlendMode(self.blend)
    end
    if self.draw_func then
        self:draw_func(P_super)
    else
        P_super:draw(self)
    end
    love.graphics.setBlendMode("alpha")
    if self.post_draw_func then self:post_draw_func() end
end

local Absorber, super = Class(Object)

function Absorber:init(x, y, o)
    if type(x) == "table" then
        o = x
        x, y = 0, 0
    end
    super:init(self, x, y)
    if type(o.layer) == "string" then o.layer = BATTLE_LAYERS[o.layer] end
    self.layer = o.layer or BATTLE_LAYERS["below_bullets"]

    self.data = {
        -- whether it will spawn particles
        auto = true,

        -- texture used for the particle
        shape = "circle",
        path = "battle/misc/shapes",

        -- list of colors or a single color
        color = {1,1,1},
        -- range of alphas or a single alpha
        alpha = 1,
        -- blend mode of particles
        blend = "alpha",
        -- scale of particles
        scale = 1,
        -- size of particles
        size = nil,
        width = nil,
        height = nil,
        -- starting rotation of particles (random by default)
        rotation = {0, 2*math.pi},
        -- how fast particles spin
        spin = 0,
        -- how fast the particle will fade
        fade = 0,
        -- time until the particle fades
        fade_after = 0,
        -- how fast the particle will fade into its alpha
        fade_in = 0,
        -- how fast the particle will shrink
        shrink = 0,
        -- time until the particle shrinks
        shrink_after = -1,

        -- how far from the origin the particle should be
        dist = 0,
        -- angle the particle should be from the origin (random by default)
        angle = {0, 2*math.pi},
        -- how long the particle should take
        move_time = 1,
        -- how the particle should ease to the origin
        ease = "linear",

        -- amount of particles per emission
        amount = 1,
        -- frequency of emission (-1 means only once)
        every = -1,
        -- how long to emit (-1 means forever)
        time = -1,
        -- whether particles should be parented to the emitter
        parent = false,
        -- whether particles should be masked to the arena
        mask = false,
        -- functions to call for the particle
        update = nil, -- function(particle)
        pre_draw = nil, --    ...(particle)
        draw = nil, --        ...(particle, super), passing in super for calling super:draw(particle)
        post_draw = nil, --   ...(particle)
        remove = nil, --      ...(particle)

        -- list of values that should be rounded
        round = {
            size = true,
            width = true,
            height = true,
            amount = true,
        },
    }

    for _k,v in pairs(o) do
        -- list of names that are synonymous with others
        local convert = {
            colors = "color",
            alphas = "alpha",
            angles = "angle",
        }
        local k = _k
        local sub_i = string.find(_k, "_")
        local subj = sub_i and string.sub(_k, 1, sub_i-1)
        if subj and convert[subj] then
            k = convert[subj]..string.sub(_k, sub_i)
        elseif convert[k] then
            k = convert[k]
        end
        if k == "round" then
            for k2,v2 in pairs(v) do
                self.data[k][k2] = v2
            end
        else
            self.data[k] = v
        end
    end

    self.timer = Timer()
    self:addChild(self.timer)
    self.particles = {}
end

function Absorber:onAdd(parent)
    super:onAdd(self, parent)
    if self:getValue("every") > 0 then
        local total_time = 0
        self.timer:script(function(wait)
            while true do
                if self:getStage() and self.data.auto and self.parent.visible then
                    self:emit()
                end
                local t = self:getValue("every")
                total_time = total_time + t
                wait(t)
                local time = self:getValue("time")
                if time > 0 and total_time >= time then break end
            end
        end)
    elseif self.data.auto and self.parent.visible then
        self:emit()
    end
end

function Absorber:emit()
    local particles = {}
    for _=1,self:getValue("amount") do
        local ox, oy = self.parent:getRelativePos(self.x, self.y, Game.battle)
        if self.data.parent then ox = 0; oy = 0 end
        local angle, dist = self:getValue("angle"), self:getValue("dist")
        local x = ox + math.cos(angle)*dist
        local y = oy + math.sin(angle)*dist
        local p = Particle(self.data.path.."/"..self:getValue("shape"), x, y)
        p:setScale(self:getValue(p, "scale"))
        p.rotation = self:getValue(p, "rotation")
        local size = self:getValue(p, "size")
        if size then
            p:setScale(size/math.max(p.width,p.height))
        else
            local w, h = self:getValue(p, "width"), self:getValue(p, "height")
            if w and h then
                p:setScale(w/p.width, h/p.height)
            end
        end
        local r,g,b,a = self:getColorValue(p)
        p.color = {r,g,b}
        p.alpha = a
        p.blend = self:getValue(p, "blend")
        local fade_in = self:getValue(p, "fade_in")
        if fade_in > 0 then
            p.alpha = 0
            p.graphics.fade_to = a
            p.graphics.fade = fade_in
        end
        p.graphics.spin = self:getValue(p, "spin")
        local fade = self:getValue(p, "fade")
        if fade > 0 then
            Game.battle.timer:after(math.max(self:getValue(p, "fade_after"), 0), function()
                p.graphics.fade_to = 0
                p.graphics.fade = fade
                p.graphics.fade_callback = p.remove
            end)
        end
        local shrink = self:getValue(p, "shrink")
        if shrink > 0 then
            Game.battle.timer:after(math.max(self:getValue(p, "shrink_after"), 0), function()
                p.graphics.remove_shrunk = true
                p.graphics.grow = -shrink
            end)
        end
        local on_remove = self:getValue(p, "remove")
        Game.battle.timer:tween(self:getValue(p, "move_time"), p, {x = ox, y = oy}, self:getValue(p, "ease"), function()
            if on_remove then
                on_remove(p)
            else
                p:remove()
            end
        end)
        p.update_func = self.data.update
        p.pre_draw_func = self.data.pre_draw
        p.draw_func = self.data.draw
        p.post_draw_func = self.data.post_draw
        p.layer = self.layer
        if self.data.parent then
            self:addChild(p)
        elseif self.data.mask then
            Game.battle.mask:addChild(p)
        else
            Game.battle:addChild(p)
        end
        table.insert(particles, p)
        table.insert(self.particles, p)
    end
    return particles
end

function Absorber:clear()
    for _,p in ipairs(self.particles) do
        local on_remove = self:getValue(p, "remove")
        if on_remove then
            on_remove(p)
        else
            p:remove()
        end
    end
end

function Absorber:getValue(particle, name, tbl)
    if type(particle) == "string" then
        tbl = name
        name = particle
    end
    tbl = tbl or self.data
    local val = tbl[name]
    while type(val) == "table" do
        if type(val[1]) == "number" then
            if #val == 1 then
                val = val[1]
                break
            else
                val = Utils.random(val[1], val[2])
                break
            end
        else
            val = Utils.pick(val)
        end
    end
    if type(val) == "number" then
        local vary = tbl[name.."_var"]
        local min, max = tbl[name.."_min_var"], tbl[name.."max_var"]
        if not min then
            min = tbl[name.."_dist"]
        end
        if min then
            if max then
                val = val + Utils.random(min, max)*Utils.randomSign()
            elseif vary then
                val = val + Utils.random(min, min+vary)*Utils.randomSign()
            else
                val = val + min*Utils.randomSign()
            end
        elseif vary then
            val = val + Utils.random(-vary, vary)
        end
    elseif type(val) == "function" then
        val = val(particle)
    end
    local round = tbl[name.."_round"] or self.data.round[name]
    if round and type(val) == "number" then
        if type(round) == "number" then
            val = Utils.round(val, round)
        else
            val = Utils.round(val, 1)
        end
    end
    return val
end

function Absorber:getColorValue(particle)
    local color = Utils.copy(self.data.color)
    if type(color[1]) == "table" then
        color = Utils.pick(color)
    end
    local r,g,b,a = unpack(color)
    if not a then
        a = self:getValue(particle, "alpha")
    end
    return r,g,b,a
end

return Absorber