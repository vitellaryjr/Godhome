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

function Particle:remove()
    if self.remove_func then
        self:remove_func(function()
            P_super:remove(self)
        end)
    else
        P_super:remove(self)
    end
end

local Emitter, super = Class(Object)

function Emitter:init(x, y, w, h, o)
    if type(w) == "table" then
        super:init(self, x, y, 0, 0)
        o = w
    else
        super:init(self, x, y, w, h)
    end
    self.layer = (type(o.layer) == "number" and o.layer) or BATTLE_LAYERS[o.layer] or BATTLE_LAYERS["below_bullets"]

    self.data = {
        layer = "below_bullets",
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
        scale_x = 1,
        scale_y = 1,
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
        fade_after = -1,
        -- how fast the particle will fade into its alpha
        fade_in = 0,
        -- how fast the particle will shrink
        shrink = 0,
        shrink_x = 0,
        shrink_y = 0,
        -- time until the particle shrinks
        shrink_after = -1,
        -- how fast the particle will grow into its size
        grow = 0,
        grow_x = 0,
        grow_y = 0,
        -- time until the particle is removed
        remove_after = -1,
        -- physics of particles
        physics = {
            speed_x = 0,
            speed_y = 0,
            speed = 0,
            friction = 0,
            gravity = 0,
            gravity_direction = math.pi/2,
        },
        -- angle the particle will move (random by default)
        angle = {0, math.pi*2},
        -- how far from the spawn position the particle should start
        dist = 0,

        -- amount of particles per emission
        amount = 1,
        -- frequency of emission (-1 means only once)
        every = -1,
        -- how long to emit (-1 means forever)
        time = -1,
        -- whether particles should be parented to the emitter
        parent = false,
        -- whether particles should be masked to the arena
        -- alternatively, can be defined as an object that particles should be masked to
        mask = false,
        -- functions to call for the particle, comments list arguments
        init = nil, -- particle
        update = nil, -- particle
        pre_draw = nil, -- particle
        draw = nil, -- particle, super
        post_draw = nil, -- particle
        remove = nil, -- particle, remove function

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
        -- list of valid suffixes that a value can have
        local suffixes = {
            "var",
            "min_var",
            "max_var",
            "dist",
            "round",
        }
        local k = _k
        local sub_i = string.find(_k, "_")
        local subj = sub_i and string.sub(_k, 1, sub_i-1)
        local suff = sub_i and string.sub(_k, sub_i+1)
        if subj and convert[subj] then
            k = convert[subj]..string.sub(_k, sub_i)
        elseif convert[k] then
            k = convert[k]
        end
        local valid_suff = Utils.containsValue(suffixes, suff)
        if self.data.physics[valid_suff and subj or k] then
            self.data.physics[k] = v
        elseif k == "round" then
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

function Emitter:onAdd(parent)
    super:onAdd(self, parent)
    local every = self:getValue("every")
    if every > 0 then
        local total_time = 0
        self.timer:script(function(wait)
            while true do
                if self:getStage() and self.data.auto and self.parent.visible then
                    self:emit()
                end
                total_time = total_time + every
                wait(every)
                local time = self:getValue("time")
                if time > 0 and total_time >= time then break end
            end
        end)
    elseif self.data.auto and self.parent.visible then
        self:emit()
    end
end

function Emitter:getParent()
    if Game.battle then
        return Game.battle
    elseif Game.world then
        return Game.world
    else
        return Game.stage
    end
end

function Emitter:emit()
    local particles = {}
    for _=1,self:getValue("amount") do
        local x, y = self.parent:getRelativePos(self.x, self.y, self:getParent())
        if self.data.parent then x = 0; y = 0 end
        if self.width > 0 then
            x = x + love.math.random(0,self.width)
        end
        if self.height > 0 then
            y = y + love.math.random(0,self.height)
        end
        local p = Particle(self.data.path.."/"..self:getValue("shape"), x, y)
        local sx, sy = self:getValue(p, "scale_x"), self:getValue(p, "scale_y")
        if sx ~= 1 or sy ~= 1 then
            p:setScale(sx, sy)
        else
            p:setScale(self:getValue(p, "scale"))
        end
        p.rotation = self:getValue(p, "rotation")
        local size = self:getValue(p, "size")
        if size then
            p.size = size
            p:setScale(size/math.max(p.width,p.height))
        else
            local w, h = self:getValue(p, "width"), self:getValue(p, "height")
            if w and h then
                p:setScale(w/p.width, h/p.height)
            end
        end
        local grow, grow_x, grow_y = self:getValue(p, "grow"), self:getValue(p, "grow_x"), self:getValue(p, "grow_y")
        if grow > 0 or grow_x > 0 or grow_y > 0 then
            local sx, sy = p:getScale()
            if grow > 0 then
                p:setScale(0)
            end
            if grow_x > 0 then
                p.scale_x = 0
            end
            if grow_y > 0 then
                p.scale_y = 0
            end
            self:getParent().timer:script(function(wait)
                local change = (grow_x > 0) and grow_x or grow
                if change > 0 then
                    while p.scale_x ~= sx do
                        p.scale_x = Utils.approach(p.scale_x, sx, change*DTMULT)
                        wait()
                    end
                end
            end)
            self:getParent().timer:script(function(wait)
                local change = (grow_y > 0) and grow_y or grow
                if change > 0 then
                    while p.scale_y ~= sy do
                        p.scale_y = Utils.approach(p.scale_y, sy, change*DTMULT)
                        wait()
                    end
                end
            end)
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
            self:getParent().timer:after(math.max(self:getValue(p, "fade_after"), 0), function()
                p.graphics.fade_to = 0
                p.graphics.fade = fade
                p.graphics.fade_callback = p.remove
            end)
        end
        local shrink, shrink_x, shrink_y = self:getValue(p, "shrink"), self:getValue(p, "shrink_x"), self:getValue(p, "shrink_y")
        if shrink > 0 or shrink_x > 0 or shrink_y > 0 then
            self:getParent().timer:after(math.max(self:getValue(p, "shrink_after"), 0), function()
                p.graphics.remove_shrunk = true
                local change_x = (shrink_x > 0) and shrink_x or shrink
                local change_y = (shrink_y > 0) and shrink_y or shrink
                p.graphics.grow_x = -change_x
                p.graphics.grow_y = -change_y
            end)
        end
        local remove = self:getValue(p, "remove_after")
        if remove > 0 then
            self:getParent().timer:after(remove, function()
                p:remove()
            end)
        end
        local angle = self:getValue(p, "angle")
        local ph = {}
        p.physics = ph
        ph.speed_x = self:getValue(p, "speed_x", self.data.physics)
        ph.speed_y = self:getValue(p, "speed_y", self.data.physics)
        ph.speed = self:getValue(p, "speed", self.data.physics)
        ph.friction = self:getValue(p, "friction", self.data.physics)
        ph.gravity = self:getValue(p, "gravity", self.data.physics)
        ph.gravity_direction = self:getValue(p, "gravity_direction", self.data.physics)
        ph.direction = angle
        local dist = self:getValue(p, "dist")
        if dist ~= 0 then
            p:setPosition(x + dist*math.cos(angle), y + dist*math.sin(angle))
        end
        p.update_func = self.data.update
        p.pre_draw_func = self.data.pre_draw
        p.draw_func = self.data.draw
        p.post_draw_func = self.data.post_draw
        p.remove_func = self.data.remove
        p.layer = self:getValue(p, "layer")
        if type(p.layer) == "string" then
            p.layer = BATTLE_LAYERS[p.layer]
        end
        if self.data.init then
            self.data.init(p)
        end
        if self.data.parent then
            self:addChild(p)
        elseif self.data.mask then
            if isClass(self.data.mask) then
                p:addFX(MaskFX(self.data.mask))
            else
                Game.battle.mask:addChild(p)
            end
        else
            self:getParent():addChild(p)
        end
        table.insert(particles, p)
        table.insert(self.particles, p)
    end
    return particles
end

function Emitter:clear()
    for _,p in ipairs(self.particles) do
        p:remove()
    end
end

function Emitter:getValue(particle, name, tbl)
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
    if type(val) == "function" then
        val = val(particle)
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
    end
    local round = tbl[name.."_round"] or (self.data.round and self.data.round[name])
    if round and type(val) == "number" then
        if type(round) == "number" then
            val = Utils.round(val, round)
        else
            val = Utils.round(val, 1)
        end
    end
    return val
end

function Emitter:getColorValue(particle)
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

return Emitter