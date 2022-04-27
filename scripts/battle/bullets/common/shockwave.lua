local Shockwave, super = Class(Bullet)

function Shockwave:init(x, y, length, height, speed)
    super:init(self, x, y)
    self:setOrigin(0, 0)
    self:setScale(1, 1)

    self.color = {1,1,1}

    self.length = length
    self.speed_dir = Utils.sign(speed)
    self.speed = math.abs(speed)

    self.width = SCREEN_WIDTH
    self.height = height

    self.wave_dist = 12
    self.wave_count = self.width/self.wave_dist
    self.wave_x = -length

    self.collider = PolygonCollider(self, {{0,0}})

    self.active_waves = {}
    self.waves = {}
    for i = 1, self.wave_count do
        table.insert(self.waves, {(i*self.wave_dist-(self.wave_dist/2))*self.speed_dir, 0})
        table.insert(self.waves, {(i*self.wave_dist)*self.speed_dir, 0})
    end
end

function Shockwave:update()
    super:update(self)

    self.wave_x = self.wave_x + self.speed * DTMULT

    local function calcHeight(x)
        return (-math.cos((Utils.clamp(x-self.wave_x, 0, self.length)/self.length)*math.pi*2)/2 + 0.5) * self.height
    end

    local hit_points = {}
    self.active_waves = {{Utils.clamp(Utils.round(self.wave_x, self.wave_dist), 0, self.width)*self.speed_dir, 0}}
    for i = 1, self.wave_count do
        local current = self.waves[(i-1)*2+1]
        local next = self.waves[i*2+1]
        local between = self.waves[i*2]

        if i == 1 then
            current[2] = -calcHeight(i*self.wave_dist-(self.wave_dist/2))
        end

        if not next then
            between[2] = 0
        else
            next[2] = -calcHeight((i+1)*self.wave_dist-(self.wave_dist/2))
            if next[2] ~= 0 then
                between[2] = (2/3)*math.max(current[2], next[2])
                table.insert(hit_points, {between[1], between[2], 0})
            else
                between[2] = 0
            end
        end

        if current[2] ~= 0 then
            table.insert(self.active_waves, current)
            table.insert(self.active_waves, between)
        end
    end

    if #hit_points > 0 then
        local first = hit_points[1]
        local last = hit_points[#hit_points]
        table.insert(hit_points, 1, {first[1], 0})
        table.insert(hit_points, {last[1], 0})
        self.collider.points = hit_points
    else
        self.collider.points = {{0, 0}}
    end

    if (self.wave_x + self.length) >= self.width then
        self:remove()
    end
end

function Shockwave:draw()
    if #self.active_waves > 2 then
        local pgon = {Utils.unpackPolygon(self.active_waves)}
        local triangles = love.math.triangulate(pgon)
        for _,triangle in ipairs(triangles) do
            love.graphics.polygon("fill", triangle)
        end
    end

    super:draw(self)
end

return Shockwave